# coding=UTF-8
from VMachine import *
from VBox import *
from Session import *

class VM_Mgr(object):

  """
   

  :version:
  :author:
  """

  """ ATTRIBUTES

   

  vms  (private)

   

  vbox  (private)

   

  session  (private)

  """

  def __init__(self, self):
    """
     

    @param VM_Mgr self : 
    @return  :
    @author
    """
    pass

  def list(self):
    """
     return list of Virtual Machines

    @return  :
    @author
    """
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


  def host(self):
    """
     

    @return  :
    @author
    """
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


  def quit(self):
    """
     

    @return  :
    @author
    """
    pass

  def connect(self):
    """
     

    @return  :
    @author
    """
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


  def disconnect(self):
    """
     

    @return  :
    @author
    """
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


  def reconnect(self):
    """
     

    @return  :
    @author
    """
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
    




