from vboxapi import VirtualBoxManager
virtualBoxManager = VirtualBoxManager(None, None)
 
vbox = virtualBoxManager.vbox
mgr = virtualBoxManager.mgr
print ("Version is", vbox.version)
 
def machById(id):
    mach = None
    for m in virtualBoxManager.getArray(vbox, 'machines'):
        if m.name == id or mach.id == id:
            mach = m
            break
    return mach
 
name = "MINIX_3"
mach = machById(name)
 
if mach is None:
    print ("cannot find machine", )
else:
    session = mgr.getSessionObject(vbox)
    progress = mach.launchVMProcess(session, "gui", mach.id)
    progress.waitForCompletion(-1)
    mgr.closeMachineSession(session)
