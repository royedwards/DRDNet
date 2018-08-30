def split_no_quotes(s):
def progressBar(ctx, progress, wait=1000):
def printErr(_ctx, e):
def reportError(_ctx, progress):
def startVm(ctx, mach, vmtype):
    def __init__(self, mach):
def cacheMachines(_ctx, lst):
def getMachines(ctx, invalidate = False, simple=False):
def asState(var):
def asFlag(var):
def getFacilityStatus(ctx, guest, facilityType):
def takeScreenshot(_ctx, console, args):
def cond(c, v1, v2):
def printHostUsbDev(ctx, ud):
def printUsbDev(_ctx, ud):
def printSf(ctx, sf):
def cmdExistingVm(ctx, mach, cmd, args):
def cmdClosedVm(ctx, mach, cmd, args=[], save=True):
def cmdAnyVm(ctx, mach, cmd, args=[], save=False):
def machById(ctx, uuid):
def argsToMach(ctx, args):
def asEnumElem(ctx, enum, elem):
def enumFromString(ctx, enum, strg):
def nh_raw_input(prompt=""):
def getCred(_ctx):
def readCmdPipe(ctx, _hcmd):
def verboseCmd(ctx, args):

def optId(verbose, uuid):
def asSize(val, inBytes):

def runCommandArgs(ctx, args):
def runCommand(ctx, cmd):
def getHomeFolder(ctx):

def runCommandCb(ctx, cmd, args):
def main(argv):

