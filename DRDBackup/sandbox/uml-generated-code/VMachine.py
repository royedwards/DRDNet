# coding=UTF-8
from Snapshot_Mgr import *
from Backup_Mgr import *
from Log import *

class VMachine(object):

  """
   A virtual machine object
   

  :version:
  :author:
  """

  """ ATTRIBUTES

   

  snapshots  (private)

   

  info  (private)

   

  backups  (private)

   

  log  (private)

  """

  def __init__(self, self):
    """
     Initialize
     

    @param VMachine self : 
    @return VMachine :
    @author
    """
    pass

  def start(self):
    """
     

    @return  :
    @author
    """
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


  def stop(self):
    """
     

    @return  :
    @author
    """
    pass

  def pause(self):
    """
     

    @return  :
    @author
    """
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'pause', '')
    return 0


  def resume(self):
    """
     

    @return  :
    @author
    """
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'resume', '')
    return 0


  def info(self):
    """
     

    @return  :
    @author
    """
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


  def powerdown(self):
    """
     

    @return  :
    @author
    """
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'powerdown', '')
    return 0


  def powerbutton(self):
    """
     

    @return  :
    @author
    """
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'powerbutton', '')
    return 0


  def save(self):
    """
     

    @return  :
    @author
    """
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'save', '')
    return 0


  def screenshot(self):
    """
     

    @return  :
    @author
    """
    if len(args) < 2:
        print("usage: screenshot vm <file> <width> <height> <monitor>")
        return 0
    mach = argsToMach(ctx, args)
    if mach == None:
        return 0
    cmdExistingVm(ctx, mach, 'screenshot', args[2:])
    return 0


  def snapshot(self):
    """
     

    @return  :
    @author
    """
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
    


  def clone(self):
    """
     

    @return  :
    @author
    """
    pass

  def export(self):
    """
     

    @return  :
    @author
    """
    pass

  def findLog(self):
    """
     

    @return  :
    @author
    """
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


  def showLog(self):
    """
     

    @return  :
    @author
    """
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
    


  def findAssert(self):
    """
     

    @return  :
    @author
    """
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


  def anyVM(self):
    """
     

    @return  :
    @author
    """
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


  def existingVM(self):
    """
     

    @return  :
    @author
    """
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


  def closedVM(self):
    """
     

    @return  :
    @author
    """
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




