#!/usr/bin/env python
'''
vboxmerge.py - Merge VirtualBox snapshots into base VDI

Run 'python vboxmerge.py --help' to display command options.

Written by Stuart Rackham, <srackham@gmail.com>
Copyright (C) 2010 Stuart Rackham. Free use of this software is
granted under the terms of the MIT License.
'''
import os, sys
import vboxapi
#import pywintypes

PROG = os.path.basename(__file__)
VERSION = '0.1.1'
VBOX = vboxapi.VirtualBoxReflectionInfo(False)  # VirtualBox constants.


def out(fmt, *args):
    if not OPTIONS.quiet:
        sys.stdout.write((fmt % args))

def die(msg, exitcode=1):
    OPTIONS.quiet = False
    out('ERROR: %s\n', msg)
    sys.exit(exitcode)

def runcmd(async_cmd, *args):
    '''
    Run the bound asynchronous method async_cmd with arguments args.
    Display progress and return once the command has completed.
    If an error occurs print the error and exit the program.
    '''
    if not OPTIONS.dryrun:
        try:
            progress = async_cmd(*args)
            while not progress.completed:
                progress.waitForCompletion(30000)   # Update progress every 30 seconds.
                out('%s%% ', progress.percent)
            out('\n')
        except pywintypes.com_error, e:
            die(e.args[2][2])   # Print COM error textual description and exit.

def vboxmerge(machine_name):
    '''
    Merge snapshots using global OPTIONS.
    '''
    vbm = vboxapi.VirtualBoxManager(None, None)
    vbox = vbm.vbox
    try:
        mach = vbox.findMachine(machine_name)
    except pywintypes.com_error:
        die('machine not found: %s' % machine_name)
    out('\nmachine: %s: %s\n', mach.name, mach.id)
    if mach.state != VBOX.MachineState_PoweredOff:
        die('machine must be powered off')
    session = vbm.mgr.getSessionObject(vbox)
    print dir(vbox)
    print 'session'
    print dir(session)
    vbox.openSession(session, mach.id)
    try:
        snap = mach.currentSnapshot
        if snap:

            if OPTIONS.discard_currentstate:
                out('\ndiscarding current machine state\n')
                runcmd(session.console.restoreSnapshot, snap)

            skip = int(OPTIONS.skip)
            count = int(OPTIONS.count)
            while snap:
                parent = snap.parent
                if skip <= 0 and count > 0:
                    out('\nmerging: %s: %s\n', snap.name, snap.id)
                    runcmd(session.console.deleteSnapshot, snap.id)

                    # The deleteSnapshot API sometimes silently skips snapshots
                    # so test to make sure the snapshot is no longer valid.
                    try: snap.id
                    except pywintypes.com_error: pass
                    else:
                        if not OPTIONS.dryrun:
                            die('%s: %s: more than one child VDI' % (snap.name, snap.id))

                    count -= 1
                snap = parent
                skip -= 1
        else:
            out('no snapshots\n')

        if OPTIONS.snapshot:
            # Create a base snapshot.
            out('\ncreating base snapshot\n')
            runcmd(session.console.takeSnapshot, 'Base', 'Created by vboxmerge')

        if OPTIONS.compact:
            # Compact the base VDI.
            for attachment in mach.mediumAttachments:
                if attachment.type == VBOX.DeviceType_HardDisk:
                    base = attachment.medium.base
                    if base.type == VBOX.MediumType_Normal:
                        out('\ncompacting base VDI: %s\n', base.name)
                        runcmd(base.compact)
    finally:
        session.close()


if __name__ == '__main__':
    description = '''Merge VirtualBox snapshots into base VDI. MACHINE is the machine name.'''
    from optparse import OptionParser
    parser = OptionParser(usage='%prog [OPTIONS] MACHINE',
        version='%s %s' % (PROG,VERSION),
        description=description)
    parser.add_option('--skip', dest='skip',
        help='skip most recent N snapshots', metavar='N', default=0)
    parser.add_option('--count', dest='count',
        help='only merge N snapshots', metavar='N', default=1000)
    parser.add_option('-q', '--quiet',
        action='store_true', dest='quiet', default=False,
        help='do not display progress messages')
    parser.add_option('-n', '--dryrun',
        action='store_true', dest='dryrun', default=False,
        help='do nothing except display what would be done')
    parser.add_option( '--compact',
        action='store_true', dest='compact', default=False,
        help='compact the base VDI')
    parser.add_option( '--snapshot',
        action='store_true', dest='snapshot', default=False,
        help='create base snapshot')
    parser.add_option( '--discard-currentstate',
        action='store_true', dest='discard_currentstate', default=False,
        help='discard the current state of the MACHINE')
    if len(sys.argv) == 1:
        parser.parse_args(['--help'])
    global OPTIONS
    (OPTIONS, args) = parser.parse_args()
    vboxmerge(args[0])

