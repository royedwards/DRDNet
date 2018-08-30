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



def cmdExistingVm(ctx, mach, cmd, args):
    session = None
    try:
        vbox = ctx['vb']
        session = ctx['global'].openMachineSession(mach, fPermitSharing=True)
    except Exception as e:
        printErr(ctx, "Session to '%s' not open: %s" % (mach.name, str(e)))
        if g_fVerbose:
            traceback.print_exc()
        return
    if session.state != ctx['const'].SessionState_Locked:
        print("Session to '%s' in wrong state: %s" % (mach.name, session.state))
        session.unlockMachine()
        return
    # this could be an example how to handle local only (i.e. unavailable
    # in Webservices) functionality
    if ctx['remote'] and cmd == 'some_local_only_command':
        print('Trying to use local only functionality, ignored')
        session.unlockMachine()
        return
    console = session.console
    ops = {'pause':           lambda: console.pause(),
           'resume':          lambda: console.resume(),
           'powerdown':       lambda: console.powerDown(),
           'powerbutton':     lambda: console.powerButton(),
           'stats':           lambda: perfStats(ctx, mach),
           'guestlambda':     lambda: args[0](ctx, mach, console, args[1:]),
           'save':            lambda: progressBar(ctx, session.machine.saveState()),
           'screenshot':      lambda: takeScreenshot(ctx, console, args),
           }
    try:
        ops[cmd]()
    except KeyboardInterrupt:
        ctx['interrupt'] = True
    except Exception as e:
        printErr(ctx, e)
        if g_fVerbose:
            traceback.print_exc()

    session.unlockMachine()


def cmdClosedVm(ctx, mach, cmd, args=[], save=True):
    session = ctx['global'].openMachineSession(mach, fPermitSharing=True)
    mach = session.machine
    try:
        cmd(ctx, mach, args)
    except Exception as e:
        save = False
        printErr(ctx, e)
        if g_fVerbose:
            traceback.print_exc()
    if save:
        try:
            mach.saveSettings()
        except Exception as e:
            printErr(ctx, e)
            if g_fVerbose:
                traceback.print_exc()
    ctx['global'].closeMachineSession(session)


def cmdAnyVm(ctx, mach, cmd, args=[], save=False):
    session = ctx['global'].openMachineSession(mach, fPermitSharing=True)
    mach = session.machine
    try:
        cmd(ctx, mach, session.console, args)
    except Exception as e:
        save = False
        printErr(ctx, e)
        if g_fVerbose:
            traceback.print_exc()
    if save:
        mach.saveSettings()
    ctx['global'].closeMachineSession(session)

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

def helpSingleCmd(cmd, h, sp):
    if sp != 0:
        spec = " [ext from "+sp+"]"
    else:
        spec = ""
    print("    %s: %s%s" % (colored(cmd, 'blue'), h, spec))

def helpCmd(_ctx, args):
    if len(args) == 1:
        print("Help page:")
        names = list(commands.keys())
        names.sort()
        for i in names:
            helpSingleCmd(i, commands[i][0], commands[i][2])
    else:
        cmd = args[1]
        c = commands.get(cmd)
        if c == None:
            print("Command '%s' not known" % (cmd))
        else:
            helpSingleCmd(cmd, c[0], c[2])
    return 0

def asEnumElem(ctx, enum, elem):
    enumVals = ctx['const'].all_values(enum)
    for e in list(enumVals.keys()):
        if str(elem) == str(enumVals[e]):
            return colored(e, 'green')
    return colored("<unknown>", 'green')

def enumFromString(ctx, enum, strg):
    enumVals = ctx['const'].all_values(enum)
    return enumVals.get(strg, None)

def listCmd(ctx, _args):
    for mach in getMachines(ctx, True):
        try:
            if mach.teleporterEnabled:
                tele = "[T] "
            else:
                tele = "    "
                print("%sMachine '%s' [%s], machineState=%s, sessionState=%s" % (tele, mach.name, mach.id, asEnumElem(ctx, "MachineState", mach.state), asEnumElem(ctx, "SessionState", mach.sessionState)))
        except Exception as e:
            printErr(ctx, e)
            if g_fVerbose:
                traceback.print_exc()
    return 0

def infoCmd(ctx, args):
    if len(args) < 2:
        print("usage: info [vmname|uuid]")
        return 0
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    vmos = ctx['vb'].getGuestOSType(mach.OSTypeId)
    print(" One can use setvar <mach> <var> <value> to change variable, using name in [].")
    print("  Name [name]: %s" % (mach.name))
    print("  Description [description]: %s" % (mach.description))
    print("  ID [n/a]: %s" % (mach.id))
    print("  OS Type [via OSTypeId]: %s" % (vmos.description))
    print("  Firmware [firmwareType]: %s (%s)" % (asEnumElem(ctx, "FirmwareType", mach.firmwareType), mach.firmwareType))
    print()
    print("  CPUs [CPUCount]: %d" % (mach.CPUCount))
    print("  RAM [memorySize]: %dM" % (mach.memorySize))
    print("  VRAM [VRAMSize]: %dM" % (mach.VRAMSize))
    print("  Monitors [monitorCount]: %d" % (mach.monitorCount))
    print("  Chipset [chipsetType]: %s (%s)" % (asEnumElem(ctx, "ChipsetType", mach.chipsetType), mach.chipsetType))
    print()
    print("  Clipboard mode [clipboardMode]: %s (%s)" % (asEnumElem(ctx, "ClipboardMode", mach.clipboardMode), mach.clipboardMode))
    print("  Machine status [n/a]: %s (%s)" % (asEnumElem(ctx, "SessionState", mach.sessionState), mach.sessionState))
    print()
    if mach.teleporterEnabled:
        print("  Teleport target on port %d (%s)" % (mach.teleporterPort, mach.teleporterPassword))
        print()
    bios = mach.BIOSSettings
    print("  ACPI [BIOSSettings.ACPIEnabled]: %s" % (asState(bios.ACPIEnabled)))
    print("  APIC [BIOSSettings.IOAPICEnabled]: %s" % (asState(bios.IOAPICEnabled)))
    hwVirtEnabled = mach.getHWVirtExProperty(ctx['global'].constants.HWVirtExPropertyType_Enabled)
    print("  Hardware virtualization [guest win machine.setHWVirtExProperty(ctx[\\'const\\'].HWVirtExPropertyType_Enabled, value)]: " + asState(hwVirtEnabled))
    hwVirtVPID = mach.getHWVirtExProperty(ctx['const'].HWVirtExPropertyType_VPID)
    print("  VPID support [guest win machine.setHWVirtExProperty(ctx[\\'const\\'].HWVirtExPropertyType_VPID, value)]: " + asState(hwVirtVPID))
    hwVirtNestedPaging = mach.getHWVirtExProperty(ctx['const'].HWVirtExPropertyType_NestedPaging)
    print("  Nested paging [guest win machine.setHWVirtExProperty(ctx[\\'const\\'].HWVirtExPropertyType_NestedPaging, value)]: " + asState(hwVirtNestedPaging))

    print("  Hardware 3d acceleration [accelerate3DEnabled]: " + asState(mach.accelerate3DEnabled))
    print("  Hardware 2d video acceleration [accelerate2DVideoEnabled]: " + asState(mach.accelerate2DVideoEnabled))

    print("  Use universal time [RTCUseUTC]: %s" % (asState(mach.RTCUseUTC)))
    print("  HPET [HPETEnabled]: %s" % (asState(mach.HPETEnabled)))
    if mach.audioAdapter.enabled:
        print("  Audio [via audioAdapter]: chip %s; host driver %s" % (asEnumElem(ctx, "AudioControllerType", mach.audioAdapter.audioController), asEnumElem(ctx, "AudioDriverType",  mach.audioAdapter.audioDriver)))
    print("  CPU hotplugging [CPUHotPlugEnabled]: %s" % (asState(mach.CPUHotPlugEnabled)))

    print("  Keyboard [keyboardHIDType]: %s (%s)" % (asEnumElem(ctx, "KeyboardHIDType", mach.keyboardHIDType), mach.keyboardHIDType))
    print("  Pointing device [pointingHIDType]: %s (%s)" % (asEnumElem(ctx, "PointingHIDType", mach.pointingHIDType), mach.pointingHIDType))
    print("  Last changed [n/a]: " + time.asctime(time.localtime(mach.lastStateChange/1000)))
    # OSE has no VRDE
    try:
        print("  VRDE server [VRDEServer.enabled]: %s" % (asState(mach.VRDEServer.enabled)))
    except:
        pass

    print()
    print("  USB Controllers:")
    for oUsbCtrl in ctx['global'].getArray(mach, 'USBControllers'):
        print("    '%s': type %s  standard: %#x" \
            % (oUsbCtrl.name, asEnumElem(ctx, "USBControllerType", oUsbCtrl.type), oUsbCtrl.USBStandard))

    print()
    print("  I/O subsystem info:")
    print("   Cache enabled [IOCacheEnabled]: %s" % (asState(mach.IOCacheEnabled)))
    print("   Cache size [IOCacheSize]: %dM" % (mach.IOCacheSize))

    controllers = ctx['global'].getArray(mach, 'storageControllers')
    if controllers:
        print()
        print(ctx, "  Storage Controllers:")
    for controller in controllers:
        print("    '%s': bus %s type %s" % (controller.name, asEnumElem(ctx, "StorageBus", controller.bus), asEnumElem(ctx, "StorageControllerType", controller.controllerType)))

    attaches = ctx['global'].getArray(mach, 'mediumAttachments')
    if attaches:
        print()
        print("  Media:")
    for a in attaches:
        print("   Controller: '%s' port/device: %d:%d type: %s (%s):" % (a.controller, a.port, a.device, asEnumElem(ctx, "DeviceType", a.type), a.type))
        medium = a.medium
        if a.type == ctx['global'].constants.DeviceType_HardDisk:
            print("   HDD:")
            print("    Id: %s" % (medium.id))
            print("    Location: %s" % (medium.location))
            print("    Name: %s" % (medium.name))
            print("    Format: %s" % (medium.format))
        if a.type == ctx['global'].constants.DeviceType_DVD:
            print("   DVD:")
            if medium:
                print("    Id: %s" % (medium.id))
                print("    Name: %s" % (medium.name))
                if medium.hostDrive:
                    print("    Host DVD %s" % (medium.location))
                    if a.passthrough:
                        print("    [passthrough mode]")
                else:
                    print("    Virtual image at %s" % (medium.location))
                    print("    Size: %s" % (medium.size))

        if a.type == ctx['global'].constants.DeviceType_Floppy:
            print("   Floppy:")
            if medium:
                print("    Id: %s" % (medium.id))
                print("    Name: %s" % (medium.name))
                if medium.hostDrive:
                    print("    Host floppy %s" % (medium.location))
                else:
                    print("    Virtual image at %s" % (medium.location))
                    print("    Size: %s" % (medium.size))

    print()
    print("  Shared folders:")
    for sf in ctx['global'].getArray(mach, 'sharedFolders'):
        printSf(ctx, sf)

    return 0

def startCmd(ctx, args):
    if len(args) < 2:
        print("usage: start name <frontend>")
        return 0
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    if len(args) > 2:
        vmtype = args[2]
    else:
        vmtype = "gui"
    startVm(ctx, mach, vmtype)
    return 0


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




def pauseCmd(ctx, args):
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'pause', '')
    return 0

def powerdownCmd(ctx, args):
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'powerdown', '')
    return 0

def powerbuttonCmd(ctx, args):
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'powerbutton', '')
    return 0

def resumeCmd(ctx, args):
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'resume', '')
    return 0

def saveCmd(ctx, args):
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'save', '')
    return 0

def statsCmd(ctx, args):
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'stats', '')
    return 0



def screenshotCmd(ctx, args):
    if len(args) < 2:
        print("usage: screenshot vm <file> <width> <height> <monitor>")
        return 0
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'screenshot', args[2:])
    return 0
    


def quitCmd(_ctx, _args):
    return 1 


def verboseCmd(ctx, args):
    global g_fVerbose
    if len(args) > 1:
        g_fVerbose = (args[1]=='on')
    else:
        g_fVerbose = not g_fVerbose
    return 0

def colorsCmd(ctx, args):
    global g_fHasColors
    if len(args) > 1:
        g_fHasColors = (args[1] == 'on')
    else:
        g_fHasColors = not g_fHasColors
    return 0

def hostCmd(ctx, args):
    vbox = ctx['vb']
    try:
        print("VirtualBox version %s" % (vbox.version))
    except Exception as e:
        printErr(ctx, e)
        if g_fVerbose:
            traceback.print_exc()
    props = vbox.systemProperties
    print("Machines: %s" % ( props.defaultMachineFolder))

    #print("Global shared folders:")
    #for ud in ctx['global'].getArray(vbox, 'sharedFolders'):
    #    printSf(ctx, sf)
    host = vbox.host
    cnt = host.processorCount
    print("Processors:")
    print("  available/online: %d/%d " % (cnt, host.processorOnlineCount))
    for i in range(0, cnt):
        print("  processor #%d speed: %dMHz %s" % (i, host.getProcessorSpeed(i), host.getProcessorDescription(i)))

    print("RAM:")
    print("  %dM (free %dM)" % (host.memorySize, host.memoryAvailable))
    print("OS:")
    print("  %s (%s)" % (host.operatingSystem, host.OSVersion))
    if host.acceleration3DAvailable:
        print("3D acceleration available")
    else:       
        print("3D acceleration NOT available")

    print("Network interfaces:")
    for ni in ctx['global'].getArray(host, 'networkInterfaces'):
        print("  %s (%s)" % (ni.name, ni.IPAddress))

    print("DVD drives:")
    for dd in ctx['global'].getArray(host, 'DVDDrives'):
        print("  %s - %s" % (dd.name, dd.description))

    print("Floppy drives:")
    for dd in ctx['global'].getArray(host, 'floppyDrives'):
        print("  %s - %s" % (dd.name, dd.description))

    print( "USB devices:")
    for ud in ctx['global'].getArray(host, 'USBDevices'):
        printHostUsbDev(ctx, ud)

    if ctx['perf']:
        for metric in ctx['perf'].query(["*"], [host]):
            print(metric['name'], metric['values_as_string'])

    return 0


def showLogCmd(ctx, args):
    if len(args) < 2:
        print("usage: showLog vm <num>")
        return 0
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0

    log = 0
    if len(args) > 2:
        log = args[2]

    uOffset = 0
    while True:
        data = mach.readLog(log, uOffset, 4096)
        if len(data) == 0:
            break
        # print adds either NL or space to chunks not ending with a NL
        sys.stdout.write(str(data))
        uOffset += len(data)

    return 0

def findLogCmd(ctx, args):
    if len(args) < 3:
        print("usage: findLog vm pattern <num>")
        return 0
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0

    log = 0
    if len(args) > 3:
        log = args[3]

    pattern = args[2]
    uOffset = 0
    while True:
        # to reduce line splits on buffer boundary
        data = mach.readLog(log, uOffset, 512*1024)
        if len(data) == 0:
            break
        d = str(data).split("\n")
        for s in d:
            match = re.findall(pattern, s)
            if len(match) > 0:
                for mt in match:
                    s = s.replace(mt, colored(mt, 'red'))
                print(s)
        uOffset += len(data)

    return 0


def findAssertCmd(ctx, args):
    if len(args) < 2:
        print("usage: findAssert vm <num>")
        return 0
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0

    log = 0
    if len(args) > 2:
        log = args[2]

    uOffset = 0
    ere = re.compile(r'(Expression:|\!\!\!\!\!\!)')
    active = False
    context = 0
    while True:
        # to reduce line splits on buffer boundary
        data = mach.readLog(log, uOffset, 512*1024)
        if len(data) == 0:
            break
        d = str(data).split("\n")
        for s in d:
            if active:
                print(s)
                if context == 0:
                    active = False
                else:
                    context = context - 1
                continue
            match = ere.findall(s)
            if len(match) > 0:
                active = True
                context = 50
                print(s)
        uOffset += len(data)

    return 0



def shellCmd(ctx, args):
    if len(args) < 2:
        print("usage: shell <commands>")
        return 0
    cmd = ' '.join(args[1:])

    try:
        os.system(cmd)
    except KeyboardInterrupt:
        # to allow shell command interruption
        pass
    return 0


def connectCmd(ctx, args):
    if len(args) > 4:
        print("usage: connect url <username> <passwd>")
        return 0

    if ctx['vb'] is not None:
        print("Already connected, disconnect first...")
        return 0

    if len(args) > 1:
        url = args[1]
    else:
        url = None

    if len(args) > 2:
        user = args[2]
    else:
        user = ""

    if len(args) > 3:
        passwd = args[3]
    else:
        passwd = ""

    ctx['wsinfo'] = [url, user, passwd]
    ctx['vb'] = ctx['global'].platform.connect(url, user, passwd)
    try:
        print("Running VirtualBox version %s" % (ctx['vb'].version))
    except Exception as e:
        printErr(ctx, e)
        if g_fVerbose:
            traceback.print_exc()
    ctx['perf'] = ctx['global'].getPerfCollector(ctx['vb'])
    return 0

def disconnectCmd(ctx, args):
    if len(args) != 1:
        print("usage: disconnect")
        return 0

    if ctx['vb'] is None:
        print("Not connected yet.")
        return 0

    try:
        ctx['global'].platform.disconnect()
    except:
        ctx['vb'] = None
        raise

    ctx['vb'] = None
    return 0

def reconnectCmd(ctx, args):
    if ctx['wsinfo'] is None:
        print("Never connected...")
        return 0

    try:
        ctx['global'].platform.disconnect()
    except:
        pass

    [url, user, passwd] = ctx['wsinfo']
    ctx['vb'] = ctx['global'].platform.connect(url, user, passwd)
    try:
        print("Running VirtualBox version %s" % (ctx['vb'].version))
    except Exception as e:
        printErr(ctx, e)
        if g_fVerbose:
            traceback.print_exc()
    ctx['perf'] = ctx['global'].getPerfCollector(ctx['vb'])
    return 0

def exportVMCmd(ctx, args):
    if len(args) < 3:
        print("usage: exportVm <machine> <path> <format> <license>")
        return 0
    mach = argsToMach(ctx, args)
    if mach is None:
        return 0
    path = args[2]
    if len(args) > 3:
        fmt = args[3]
    else:
        fmt = "ovf-1.0"
    if len(args) > 4:
        lic = args[4]
    else:
        lic = "GPL"

    app = ctx['vb'].createAppliance()
    desc = mach.export(app)
    desc.addDescription(ctx['global'].constants.VirtualSystemDescriptionType_License, lic, "")
    progress = app.write(fmt, path)
    if (progressBar(ctx, progress) and int(progress.resultCode) == 0):
        print("Exported to %s in format %s" % (path, fmt))
    else:
        reportError(ctx, progress)
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
    if (len(args) < 2 or args[1] == 'help'):
        print("Take snapshot:    snapshot vm take name <description>")
        print("Restore snapshot: snapshot vm restore name")
        print("Merge snapshot:   snapshot vm merge name")
        return 0

    mach = argsToMach(ctx, args)
    if mach is None:
        return 0
    cmd = args[2]
    if cmd == 'take':
        if len(args) < 4:
            print("usage: snapshot vm take name <description>")
            return 0
        name = args[3]
        if len(args) > 4:
            desc = args[4]
        else:
            desc = ""
        cmdAnyVm(ctx, mach, lambda ctx, mach, console, args: progressBar(ctx, mach.takeSnapshot(name, desc, True)[0]))
        return 0

    if cmd == 'restore':
        if len(args) < 4:
            print("usage: snapshot vm restore name")
            return 0
        name = args[3]
        snap = mach.findSnapshot(name)
        cmdAnyVm(ctx, mach, lambda ctx, mach, console, args: progressBar(ctx, mach.restoreSnapshot(snap)))
        return 0

    if cmd == 'restorecurrent':
        if len(args) < 4:
            print("usage: snapshot vm restorecurrent")
            return 0
        snap = mach.currentSnapshot()
        cmdAnyVm(ctx, mach, lambda ctx, mach, console, args: progressBar(ctx, mach.restoreSnapshot(snap)))
        return 0

    if cmd == 'delete':
        if len(args) < 4:
            print("usage: snapshot vm delete name")
            return 0
        name = args[3]
        snap = mach.findSnapshot(name)
        cmdAnyVm(ctx, mach, lambda ctx, mach, console, args: progressBar(ctx, mach.deleteSnapshot(snap.id)))
        return 0

    print("Command '%s' is unknown" % (cmd))
    return 0

def promptCmd(ctx, args):
    if    len(args) < 2:
        print("Current prompt: '%s'" % (ctx['prompt']))
        return 0

    ctx['prompt'] = args[1]
    return 0

    
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

