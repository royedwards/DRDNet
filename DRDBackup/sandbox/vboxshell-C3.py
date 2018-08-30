#!/usr/bin/env python
# -*- coding: utf-8 -*-
# $Id$

"""
VirtualBox Python Shell.

This program is a simple interactive shell for VirtualBox. You can query
information and issue commands from a simple command line.

It also provides you with examples on how to use VirtualBox's Python API.
This shell is even somewhat documented, supports TAB-completion and
history if you have Python readline installed.

Finally, shell allows arbitrary custom extensions, just create
.VirtualBox/shexts/ and drop your extensions there.
                                               Enjoy.

P.S. Our apologies for the code quality.
"""

from __future__ import print_function

__copyright__ = \
"""
Copyright (C) 2009-2017 Oracle Corporation

This file is part of VirtualBox Open Source Edition (OSE), as
available from http://www.virtualbox.org. This file is free software;
you can redistribute it and/or modify it under the terms of the GNU
General Public License (GPL) as published by the Free Software
Foundation, in version 2 as it comes in the "COPYING" file of the
VirtualBox OSE distribution. VirtualBox OSE is distributed in the
hope that it will be useful, but WITHOUT ANY WARRANTY of any kind.
"""
__version__ = "$Revision$"


import gc
import os
import sys
import traceback
import shlex
import time
import re
import platform
from optparse import OptionParser


#
# Global Variables
#
g_fBatchMode = False
g_sScriptFile = None
g_sCmd = None
g_fHasReadline = True
try:
    import readline
except ImportError:
    g_fHasReadline = False

g_sPrompt = "vbox> "

g_fHasColors  = False

def colored(strg, color):
    return strg


g_fVerbose = False

def split_no_quotes(s):
    return shlex.split(s)

def progressBar(ctx, progress, wait=1000):
    try:
        while not progress.completed:
            print("%s %%\r" % (colored(str(progress.percent), 'red')), end="")
            sys.stdout.flush()
            progress.waitForCompletion(wait)
            ctx['global'].waitForEvents(0)
        if int(progress.resultCode) != 0:
            reportError(ctx, progress)
        return 1
    except KeyboardInterrupt:
        print("Interrupted.")
        ctx['interrupt'] = True
        if progress.cancelable:
            print("Canceling task...")
            progress.cancel()
        return 0

def printErr(_ctx, e):
    oVBoxMgr = _ctx['global']
    if oVBoxMgr.errIsOurXcptKind(e):
        print(colored('%s: %s' % (oVBoxMgr.xcptToString(e), oVBoxMgr.xcptGetMessage(e)), 'red'))
    else:
        print(colored(str(e), 'red'))

def reportError(_ctx, progress):
    errorinfo = progress.errorInfo
    if errorinfo:
        print(colored("Error in module '%s': %s" % (errorinfo.component, errorinfo.text), 'red'))



def startVm(ctx, mach, vmtype):
    vbox = ctx['vb']
    perf = ctx['perf']
    session = ctx['global'].getSessionObject()
    progress = mach.launchVMProcess(session, vmtype, "")
    if progressBar(ctx, progress, 100) and int(progress.resultCode) == 0:
        # we ignore exceptions to allow starting VM even if
        # perf collector cannot be started
        if perf:
            try:
                perf.setup(['*'], [mach], 10, 15)
            except Exception as e:
                printErr(ctx, e)
                if g_fVerbose:
                    traceback.print_exc()
        session.unlockMachine()

class CachedMach:
    def __init__(self, mach):
        if mach.accessible:
            self.name = mach.name
        else:
            self.name = '<inaccessible>'
        self.id = mach.id

def cacheMachines(_ctx, lst):
    result = []
    for mach in lst:
        elem = CachedMach(mach)
        result.append(elem)
    return result

def getMachines(ctx, invalidate = False, simple=False):
    if ctx['vb'] is not None:
        if ctx['_machlist'] is None or invalidate:
            ctx['_machlist'] = ctx['global'].getArray(ctx['vb'], 'machines')
            ctx['_machlistsimple'] = cacheMachines(ctx, ctx['_machlist'])
        if simple:
            return ctx['_machlistsimple']
        else:
            return ctx['_machlist']
    else:
        return []

def asState(var):
    if var:
        return colored('on', 'green')
    else:
        return colored('off', 'green')

def asFlag(var):
    if var:
        return 'yes'
    else:
        return 'no'

def getFacilityStatus(ctx, guest, facilityType):
    (status, _timestamp) = guest.getFacilityStatus(facilityType)
    return asEnumElem(ctx, 'AdditionsFacilityStatus', status)

def perfStats(ctx, mach):
    if not ctx['perf']:
        return
    for metric in ctx['perf'].query(["*"], [mach]):
        print(metric['name'], metric['values_as_string'])

g_tsLast = 0


def takeScreenshotOld(_ctx, console, args):
    from PIL import Image
    display = console.display
    if len(args) > 0:
        f = args[0]
    else:
        f = "/tmp/screenshot.png"
    if len(args) > 3:
        screen = int(args[3])
    else:
        screen = 0
    (fbw, fbh, _fbbpp, fbx, fby, _) = display.getScreenResolution(screen)
    if len(args) > 1:
        w = int(args[1])
    else:
        w = fbw
    if len(args) > 2:
        h = int(args[2])
    else:
        h = fbh

    print("Saving screenshot (%d x %d) screen %d in %s..." % (w, h, screen, f))
    data = display.takeScreenShotToArray(screen, w, h, _ctx['const'].BitmapFormat_RGBA)
    size = (w, h)
    mode = "RGBA"
    im = Image.frombuffer(mode, size, str(data), "raw", mode, 0, 1)
    im.save(f, "PNG")

def takeScreenshot(_ctx, console, args):
    display = console.display
    if len(args) > 0:
        f = args[0]
    else:
        f = "/tmp/screenshot.png"
    if len(args) > 3:
        screen = int(args[3])
    else:
        screen = 0
    (fbw, fbh, _fbbpp, fbx, fby, _) = display.getScreenResolution(screen)
    if len(args) > 1:
        w = int(args[1])
    else:
        w = fbw
    if len(args) > 2:
        h = int(args[2])
    else:
        h = fbh

    print("Saving screenshot (%d x %d) screen %d in %s..." % (w, h, screen, f))
    data = display.takeScreenShotToArray(screen, w, h, _ctx['const'].BitmapFormat_PNG)
    pngfile = open(f, 'wb')
    pngfile.write(data)
    pngfile.close()

def guestStats(ctx, console, args):
    guest = console.guest
    # we need to set up guest statistics
    if len(args) > 0 :
        update = args[0]
    else:
        update = 1
    if guest.statisticsUpdateInterval != update:
        guest.statisticsUpdateInterval = update
        try:
            time.sleep(float(update)+0.1)
        except:
            # to allow sleep interruption
            pass
    all_stats = ctx['const'].all_values('GuestStatisticType')
    cpu = 0
    for s in list(all_stats.keys()):
        try:
            val = guest.getStatistic( cpu, all_stats[s])
            print("%s: %d" % (s, val))
        except:
            # likely not implemented
            pass



def cond(c, v1, v2):
    if c:
        return v1
    else:
        return v2

def printHostUsbDev(ctx, ud):
    print("  %s: %s (vendorId=%d productId=%d serial=%s) %s" % (ud.id, colored(ud.product, 'blue'), ud.vendorId, ud.productId, ud.serialNumber, asEnumElem(ctx, 'USBDeviceState', ud.state)))

def printUsbDev(_ctx, ud):
    print("  %s: %s (vendorId=%d productId=%d serial=%s)" % (ud.id,  colored(ud.product, 'blue'), ud.vendorId, ud.productId, ud.serialNumber))

def printSf(ctx, sf):
    print("    name=%s host=%s %s %s" % (sf.name, sf.hostPath, cond(sf.accessible, "accessible", "not accessible"), cond(sf.writable, "writable", "read-only")))



def machById(ctx, uuid):
    mach = ctx['vb'].findMachine(uuid)
    return mach

def argsToMach(ctx, args):
    if len(args) < 2:
        print("usage: %s [vmname|uuid]" % (args[0]))
        return None
    uuid = args[1]
    mach = machById(ctx, uuid)
    if mach == None:
        print("Machine '%s' is unknown, use list command to find available machines" % (uuid))
    return mach



def asEnumElem(ctx, enum, elem):
    enumVals = ctx['const'].all_values(enum)
    for e in list(enumVals.keys()):
        if str(elem) == str(enumVals[e]):
            return colored(e, 'green')
    return colored("<unknown>", 'green')

def enumFromString(ctx, enum, strg):
    enumVals = ctx['const'].all_values(enum)
    return enumVals.get(strg, None)


def nh_raw_input(prompt=""):
    stream = sys.stdout
    prompt = str(prompt)
    if prompt:
        stream.write(prompt)
    line = sys.stdin.readline()
    if not line:
        raise EOFError
    if line[-1] == '\n':
        line = line[:-1]
    return line


def getCred(_ctx):
    import getpass
    user = getpass.getuser()
    user_inp = nh_raw_input("User (%s): " % (user))
    if len(user_inp) > 0:
        user = user_inp
    passwd = getpass.getpass()

    return (user, passwd)



def readCmdPipe(ctx, _hcmd):
    try:
        return ctx['process'].communicate()[0]
    except:
        return None


def statsCmd(ctx, args):
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'stats', '')
    return 0



def screenshotCmd(ctx, args):

    


def quitCmd(_ctx, _args):
    return 1 


def verboseCmd(ctx, args):
    global g_fVerbose
    if len(args) > 1:
        g_fVerbose = (args[1]=='on')
    else:
        g_fVerbose = not g_fVerbose
    return 0



def optId(verbose, uuid):
    if verbose:
        return ": "+uuid
    else:
        return ""

def asSize(val, inBytes):
    if inBytes:
        return int(val)/(1024*1024)
    else:
        return int(val)

def snapshotCmd(ctx, args):


    
aliases = {'s':'start',
           'i':'info',
           'l':'list',
           'h':'help',
           'a':'alias',
           'q':'quit', 'exit':'quit',
           'tg': 'typeGuest',
           'v':'verbose'}


commands = {'help':['Prints help information', helpCmd, 0],
            'start':['Start virtual machine by name or uuid: start Linux headless', startCmd, 0],
            'pause':['Pause virtual machine', pauseCmd, 0],
            'resume':['Resume virtual machine', resumeCmd, 0],
            'save':['Save execution state of virtual machine', saveCmd, 0],
            'stats':['Stats for virtual machine', statsCmd, 0],
            'powerdown':['Power down virtual machine', powerdownCmd, 0],
            'powerbutton':['Effectively press power button', powerbuttonCmd, 0],
            'list':['Shows known virtual machines', listCmd, 0],
            'info':['Shows info on machine', infoCmd, 0],
            'verbose':['Toggle verbosity', verboseCmd, 0],
            'quit':['Exits', quitCmd, 0],
            'host':['Show host information', hostCmd, 0],
            'showLog':['Show log file of the VM, : showLog Win32', showLogCmd, 0],
            'findLog':['Show entries matching pattern in log file of the VM, : findLog Win32 PDM|CPUM', findLogCmd, 0],
            'findAssert':['Find assert in log file of the VM, : findAssert Win32', findAssertCmd, 0],
            'shell':['Execute external shell command: shell "ls /etc/rc*"', shellCmd, 0],
            'exportVm':['Export VM in OVF format: exportVm Win /tmp/win.ovf', exportVMCmd, 0],
            'screenshot':['Take VM screenshot to a file: screenshot Win /tmp/win.png 1024 768 0', screenshotCmd, 0],
            'colors':['Toggle colors', colorsCmd, 0],
            'snapshot':['VM snapshot manipulation, snapshot help for more info', snapshotCmd, 0],
            'prompt' : ['Control shell prompt', promptCmd, 0],
            }

def runCommandArgs(ctx, args):
    c = args[0]
    if aliases.get(c, None) != None:
        c = aliases[c]
    ci = commands.get(c, None)
    if ci == None:
        print("Unknown command: '%s', type 'help' for list of known commands" % (c))
        return 0
    if ctx['remote'] and ctx['vb'] is None:
        if c not in ['connect', 'reconnect', 'help', 'quit']:
            print("First connect to remote server with %s command." % (colored('connect', 'blue')))
            return 0
    return ci[1](ctx, args)


def runCommand(ctx, cmd):
    if not cmd: return 0
    args = split_no_quotes(cmd)
    if len(args) == 0: return 0
    return runCommandArgs(ctx, args)

def getHomeFolder(ctx):
    if ctx['remote'] or ctx['vb'] is None:
        if 'VBOX_USER_HOME' in os.environ:
            return os.path.join(os.environ['VBOX_USER_HOME'])
        return os.path.join(os.path.expanduser("~"), ".VirtualBox")
    else:
        return ctx['vb'].homeFolder

def interpret(ctx):
    if ctx['remote']:
        commands['connect'] = ["Connect to remote VBox instance: connect http://server:18083 user password", connectCmd, 0]
        commands['disconnect'] = ["Disconnect from remote VBox instance", disconnectCmd, 0]
        commands['reconnect'] = ["Reconnect to remote VBox instance", reconnectCmd, 0]
        ctx['wsinfo'] = ["http://localhost:18083", "", ""]

    vbox = ctx['vb']
    if vbox is not None:
        try:
            print("Running VirtualBox version %s" % (vbox.version))
        except Exception as e:
            printErr(ctx, e)
            if g_fVerbose:
                traceback.print_exc()
        ctx['perf'] = None # ctx['global'].getPerfCollector(vbox)
    else:
        ctx['perf'] = None

    home = getHomeFolder(ctx)
    if platform.system() in ['Windows', 'Microsoft']:
        global g_fHasColors
        g_fHasColors = False
    hist_file = os.path.join(home, ".vboxshellhistory")

    if g_fHasReadline and os.path.exists(hist_file):
        readline.read_history_file(hist_file)

    # to allow to print actual host information, we collect info for
    # last 150 secs maximum, (sample every 10 secs and keep up to 15 samples)
    if ctx['perf']:
        try:
            ctx['perf'].setup(['*'], [vbox.host], 10, 15)
        except:
            pass
    cmds = []

    if g_sCmd is not None:
        cmds = g_sCmd.split(';')
    it = cmds.__iter__()

    while True:
        try:
            if g_fBatchMode:
                cmd = 'runScript %s'% (g_sScriptFile)
            elif g_sCmd is not None:
                cmd = next(it)
            else:
                if sys.version_info[0] <= 2:
                    cmd = raw_input(ctx['prompt'])
                else:
                    cmd = input(ctx['prompt'])
            done = runCommand(ctx, cmd)
            if done != 0: break
            if g_fBatchMode:
                break
        except KeyboardInterrupt:
            print('====== You can type quit or q to leave')
        except StopIteration:
            break
        except EOFError:
            break
        except Exception as e:
            printErr(ctx, e)
            if g_fVerbose:
                traceback.print_exc()
        ctx['global'].waitForEvents(0)
    try:
        # There is no need to disable metric collection. This is just an example.
        if ctx['perf']:
            ctx['perf'].disable(['*'], [vbox.host])
    except:
        pass
    if g_fHasReadline:
        readline.write_history_file(hist_file)

def runCommandCb(ctx, cmd, args):
    args.insert(0, cmd)
    return runCommandArgs(ctx, args)

def main(argv):

    #
    # Parse command line arguments.
    #
    parse = OptionParser()
    parse.add_option("-v", "--verbose", dest="verbose", action="store_true", default=False, help = "switch on verbose")
    parse.add_option("-a", "--autopath", dest="autopath", action="store_true", default=False, help = "switch on autopath")
    parse.add_option("-w", "--webservice", dest="style", action="store_const", const="WEBSERVICE", help = "connect to webservice")
    parse.add_option("-b", "--batch", dest="batch_file", help = "script file to execute")
    parse.add_option("-c", dest="command_line", help = "command sequence to execute")
    parse.add_option("-o", dest="opt_line", help = "option line")
    global g_fVerbose, g_sScriptFile, g_fBatchMode, g_fHasColors, g_fHasReadline, g_sCmd
    (options, args) = parse.parse_args()
    g_fVerbose = options.verbose
    style = options.style
    if options.batch_file is not None:
        g_fBatchMode = True
        g_fHasColors = False
        g_fHasReadline = False
        g_sScriptFile = options.batch_file
    if options.command_line is not None:
        g_fHasColors = False
        g_fHasReadline = False
        g_sCmd = options.command_line

    params = None
    if options.opt_line is not None:
        params = {}
        strparams = options.opt_line
        strparamlist = strparams.split(',')
        for strparam in strparamlist:
            (key, value) = strparam.split('=')
            params[key] = value

    if options.autopath:
        asLocations = [ os.getcwd(), ]
        try:    sScriptDir = os.path.dirname(os.path.abspath(__file__))
        except: pass # In case __file__ isn't there.
        else:
            if platform.system() in [ 'SunOS', ]:
                asLocations.append(os.path.join(sScriptDir, 'amd64'))
            asLocations.append(sScriptDir)


        sPath = os.environ.get("VBOX_PROGRAM_PATH")
        if sPath is None:
            for sCurLoc in asLocations:
                if   os.path.isfile(os.path.join(sCurLoc, "VirtualBox")) \
                  or os.path.isfile(os.path.join(sCurLoc, "VirtualBox.exe")):
                    print("Autodetected VBOX_PROGRAM_PATH as", sCurLoc)
                    os.environ["VBOX_PROGRAM_PATH"] = sCurLoc
                    sPath = sCurLoc
                    break
        if sPath:
            sys.path.append(os.path.join(sPath, "sdk", "installer"))

        sPath = os.environ.get("VBOX_SDK_PATH")
        if sPath is None:
            for sCurLoc in asLocations:
                if os.path.isfile(os.path.join(sCurLoc, "sdk", "bindings", "VirtualBox.xidl")):
                    sCurLoc = os.path.join(sCurLoc, "sdk")
                    print("Autodetected VBOX_SDK_PATH as", sCurLoc)
                    os.environ["VBOX_SDK_PATH"] = sCurLoc
                    sPath = sCurLoc
                    break
        if sPath:
            sCurLoc = sPath
            sTmp = os.path.join(sCurLoc, 'bindings', 'xpcom', 'python')
            if os.path.isdir(sTmp):
                sys.path.append(sTmp)
            del sTmp
        del sPath, asLocations


    #
    # Set up the shell interpreter context and start working.
    #
    from vboxapi import VirtualBoxManager
    oVBoxMgr = VirtualBoxManager(style, params)
    ctx = {
        'global':       oVBoxMgr,
        'vb':           oVBoxMgr.getVirtualBox(),
        'const':        oVBoxMgr.constants,
        'remote':       oVBoxMgr.remote,
        'type':         oVBoxMgr.type,
        'run':          lambda cmd, args: runCommandCb(ctx, cmd, args),
        'machById':     lambda uuid: machById(ctx, uuid),
        'argsToMach':   lambda args: argsToMach(ctx, args),
        'progressBar':  lambda p: progressBar(ctx, p),
        '_machlist':    None,
        'prompt':       g_sPrompt,
        'scriptLine':   0,
        'interrupt':    False,
    }
    interpret(ctx)

    #
    # Release the interfaces references in ctx before cleaning up.
    #
    for sKey in list(ctx.keys()):
        del ctx[sKey]
    ctx = None
    gc.collect()

    oVBoxMgr.deinit()
    del oVBoxMgr

if __name__ == '__main__':
    main(sys.argv)

