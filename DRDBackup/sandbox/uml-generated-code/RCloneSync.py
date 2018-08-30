# coding=UTF-8
from object import *

class RCloneSync (object):

  """
   

  :version:
  :author:
  """

  """ ATTRIBUTES

   

  lineFormat  (public)

   

  lockfile  (public)

  """

  def bidirSync(self):
    """
      '/home/<user>/.RCloneSyncWD/Remote__some_path_' or
     '/home/<user>/.RCloneSyncWD/Remote_'
     '/home/<user>/.RCloneSyncWD/Remote__some_path_llocalLSL'  (extra 'l' to make the
     dir list pretty) '/home/<user>/.RCloneSyncWD/Remote__some_path_remoteLSL' If
     dryrun, original LSL files are preserved and lsl's are done to the _DRYRUN files
     rclone call wrapper functions with retries ***** FIRSTSYNC generate local and
     remote file lists, and copy any unique Remote files to Local *****  ***** Check
     for existance of prior local and remote lsl files ***** On prior critical error
     abort, the prior LSL files are renamed to _ERRROR to lock out further runs *****
     Check basic health of access to the local and remote filesystems ***** _*ChkLSL
     files will be left if the check fails.  Look at these files for clues. ***** Get
     current listings of the local and remote trees ***** ***** Load Current and
     Prior listings of both Local and Remote trees ***** Successful load of the file
     return status = 0 ***** Check for LOCAL deltas relative to the prior sync Now
     local version is older than prior sync sort the deltas list ***** Check for
     REMOTE deltas relative to the prior sync Current remote version is older than
     prior sync  sort the deltas list ***** Check for too many deleted files -
     possible error condition and don't want to start deleting on the other side !!!
     Local error message placed here so that it is at the end of the listed changes
     for both ***** Update LOCAL with all the changes on REMOTE *****logging.info
     (printMsg ("REMOTE", "  New file", key)) File is new on remote, does not exist
     on local File is new on remote AND new on local Rename local File is newer on
     remote, unchanged on local File is newer on remote AND also changed
     (newer/older/size) on local Rename local File is newer on remote AND also
     deleted locally File is deleted on remote, unchanged locally File is deleted on
     remote AND changed (newer/older/size) on local Local version survives#          
      else:#                if key in localNow:#                    src  = localRoot
     + '/' + key #                    dest = localRoot + '/' + key + '_LOCAL' #      
                  logging.warning (printMsg ("*****", "  Also changed locally",
     key))#                    logging.warning (printMsg ("LOCAL", "  Renaming
     local", dest))#                    if subprocess.call(shlex.split("rclone moveto
     " + src + dest + switches)):#                        logging.error (printMsg
     ("*****", "Failed rclone moveto.  (Line
     {})".format(inspect.getframeinfo(inspect.currentframe()).lineno-1), src));
     return RTN_CRITICAL File is deleted on local AND changed (newer/older/size) on
     remote ***** Sync LOCAL changes to REMOTE *****  switches = '' #'--ignore-size '
     ***** Clean up *****

    @return string :
    @author
    """
    logging.warning("Synching Remote path  <{}>  with Local path  <{}>".format(remotePathBase,localPathBase))
    global localListFile,remoteListFile
    def printMsg(self,locale,msg,key=''):
      return"  {:9}{:35} - {}".format(locale,msg,key)
    
    excludes=[]
    if exclusions:
      if not os.path.exists(exclusions):
        logging.error("Specified Exclusions file does not exist:  "+exclusions)
        return RTN_ABORT
    
      excludes.append("--exclude-from")
      excludes.append(exclusions)
    
    listFileBase=localWD+remotePathBase.replace(':','_').replace(r'/','_')
    localListFile=listFileBase+'_llocalLSL'
    remoteListFile=listFileBase+'_remoteLSL'
    switches=[]
    for x in range(rcVerbose):
      switches.append("-v")
    
    if dryRun:
      switches.append("--dry-run")
      if os.path.exists(localListFile):
        subprocess.call(['cp',localListFile,localListFile+'_DRYRUN'])
        localListFile+='_DRYRUN'
    
      if os.path.exists(remoteListFile):
        subprocess.call(['cp',remoteListFile,remoteListFile+'_DRYRUN'])
        remoteListFile+='_DRYRUN'
    
    
    maxTries=3
    def rcloneLSL(self,path,ofile,options=None,linenum=0):
      for x in range(maxTries):
        with open(ofile,"w")as of:
          processArgs=["rclone","lsl",path]
          if not options==None:processArgs.extend(options)
          if not subprocess.call(processArgs,stdout=of):return 0
          logging.warning(printMsg("WARNING","rclone lsl try {} failed.".format(x),path))
    
    
      logging.error(printMsg("ERROR","rclone lsl failed.  Specified path invalid?  (Line {})".format(linenum),path))
      return 1
    
    def rcloneCmd(self,cmd,p1=None,p2=None,options=None,linenum=0):
      for x in range(maxTries):
        processArgs=["rclone",cmd]
        if p1:processArgs.append(p1)
        if p2:processArgs.append(p2)
        if not options==None:processArgs.extend(options)
        if not subprocess.call(processArgs):return 0
        logging.warning(printMsg("WARNING","rclone {} try {} failed.".format(cmd,x),p1))
    
      logging.error(printMsg("ERROR","rclone {} failed.  (Line {})".format(cmd,linenum),p1))
      return 1
    
    if firstSync:
      logging.info(">>>>> Generating --FirstSync Local and Remote lists")
      if rcloneLSL(localPathBase,localListFile,excludes,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
      if rcloneLSL(remotePathBase,remoteListFile,excludes,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
      status,localNow=loadList(localListFile)
      if status:logging.error(printMsg("ERROR","Failed loading local list file <{}>".format(localListFile)))
      return RTN_CRITICAL
      status,remoteNow=loadList(remoteListFile)
      if status:logging.error(printMsg("ERROR","Failed loading remote list file <{}>".format(remoteListFile)))
      return RTN_CRITICAL
      for key in remoteNow:
        if key not in localNow:
          src=remotePathBase+key
          dest=localPathBase+key
          logging.info(printMsg("REMOTE","  Copying to local",dest))
          if rcloneCmd('copyto',src,dest,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
    
      if rcloneLSL(localPathBase,localListFile,excludes,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
    if not os.path.exists(localListFile)or not os.path.exists(remoteListFile):
      logging.error("***** Cannot find prior local or remote lsl files.")
      return RTN_CRITICAL
    
    if checkAccess:
      logging.info(">>>>> Checking rclone Local and Remote filesystems access health")
      localChkListFile=listFileBase+'_localChkLSL'
      remoteChkListFile=listFileBase+'_remoteChkLSL'
      chkFile='RCLONE_TEST'
      if rcloneLSL(localPathBase,localChkListFile,['--include',chkFile],linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_ABORT
      if rcloneLSL(remotePathBase,remoteChkListFile,['--include',chkFile],linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_ABORT
      status,localCheck=loadList(localChkListFile)
      if status:logging.error(printMsg("ERROR","Failed loading local check list file <{}>".format(localChkListFile)))
      return RTN_CRITICAL
      status,remoteCheck=loadList(remoteChkListFile)
      if status:logging.error(printMsg("ERROR","Failed loading remote check list file <{}>".format(remoteChkListFile)))
      return RTN_CRITICAL
      if len(localCheck)<1 or len(localCheck)!=len(remoteCheck):
        logging.error(printMsg("ERROR","Failed access health test:  <{}> local count {}, remote count {}"
        .format(chkFile,len(localCheck),len(remoteCheck)),""))
        return RTN_CRITICAL
      else:
        for key in localCheck:
          logging.debug("Check key <{}>".format(key))
          if key not in remoteCheck:
            logging.error(printMsg("ERROR","Failed access health test:  Local key <{}> not found in remote".format(key),""))
            return RTN_CRITICAL
    
    
    
      os.remove(localChkListFile)
      os.remove(remoteChkListFile)
    
    logging.info(">>>>> Generating Local and Remote lists")
    localListFileNew=listFileBase+'_llocalLSL_new'
    if rcloneLSL(localPathBase,localListFileNew,excludes,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    remoteListFileNew=listFileBase+'_remoteLSL_new'
    if rcloneLSL(remotePathBase,remoteListFileNew,excludes,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    status,localPrior=loadList(localListFile)
    if status:logging.error(printMsg("ERROR","Failed loading prior local list file <{}>".format(localListFile)))
    return RTN_CRITICAL
    if len(localPrior)==0:logging.error(printMsg("ERROR","Zero length in prior local list file <{}>".format(localListFile)))
    return RTN_CRITICAL
    status,remotePrior=loadList(remoteListFile)
    if status:logging.error(printMsg("ERROR","Failed loading prior remote list file <{}>".format(remoteListFile)))
    return RTN_CRITICAL
    if len(remotePrior)==0:logging.error(printMsg("ERROR","Zero length in prior remote list file <{}>".format(remoteListFile)))
    return RTN_CRITICAL
    status,localNow=loadList(localListFileNew)
    if status:logging.error(printMsg("ERROR","Failed loading current local list file <{}>".format(localListFileNew)))
    return RTN_ABORT
    if len(localNow)==0:logging.error(printMsg("ERROR","Zero length in current local list file <{}>".format(localListFileNew)))
    return RTN_ABORT
    status,remoteNow=loadList(remoteListFileNew)
    if status:logging.error(printMsg("ERROR","Failed loading current remote list file <{}>".format(remoteListFileNew)))
    return RTN_ABORT
    if len(remoteNow)==0:logging.error(printMsg("ERROR","Zero length in current remote list file <{}>".format(remoteListFileNew)))
    return RTN_ABORT
    logging.info(printMsg("LOCAL","Checking for Diffs",localPathBase))
    localDeltas=:
    
    
    localDeleted=0
    for key in localPrior:
      _newer=False
      _older=False
      _size=False
      _deleted=False
      if key not in localNow:
        logging.info(printMsg("LOCAL","  File was deleted",key))
        localDeleted+=1
        _deleted=True
    
      else:
        if localPrior[key]['datetime']!=localNow[key]['datetime']:
          if localPrior[key]['datetime']<localNow[key]['datetime']:
            logging.info(printMsg("LOCAL","  File is newer",key))
            _newer=True
    
          else:
            logging.info(printMsg("LOCAL","  File is OLDER",key))
            _older=True
    
    
        if localPrior[key]['size']!=localNow[key]['size']:
          logging.info(printMsg("LOCAL","  File size is different",key))
          _size=True
    
    
      if _newer or _older or _size or _deleted:
        localDeltas[key]=:
          'new':False,'newer':_newer,'older':_older,'size':_size,'deleted':_deleted
    
    
    
    for key in localNow:
      if key not in localPrior:
        logging.info(printMsg("LOCAL","  File is new",key))
        localDeltas[key]=:
          'new':True,'newer':False,'older':False,'size':False,'deleted':False
    
    
    
    localDeltas=collections.OrderedDict(sorted(localDeltas.items()))
    if len(localDeltas)>0:
      news=newers=olders=deletes=0
      for key in localDeltas:
        if localDeltas[key]['new']:news+=1
        if localDeltas[key]['newer']:newers+=1
        if localDeltas[key]['older']:olders+=1
        if localDeltas[key]['deleted']:deletes+=1
    
      logging.warning("  {:4} file change(s) on LOCAL:  {:4} new, {:4} newer, {:4} older, {:4} deleted".format(len(localDeltas),news,newers,olders,deletes))
    
    logging.info(printMsg("REMOTE","Checking for Diffs",remotePathBase))
    remoteDeltas=:
    
    
    remoteDeleted=0
    for key in remotePrior:
      _newer=False
      _older=False
      _size=False
      _deleted=False
      if key not in remoteNow:
        logging.info(printMsg("REMOTE","  File was deleted",key))
        remoteDeleted+=1
        _deleted=True
    
      else:
        if remotePrior[key]['datetime']!=remoteNow[key]['datetime']:
          if remotePrior[key]['datetime']<remoteNow[key]['datetime']:
            logging.info(printMsg("REMOTE","  File is newer",key))
            _newer=True
    
          else:
            logging.info(printMsg("REMOTE","  File is OLDER",key))
            _older=True
    
    
        if remotePrior[key]['size']!=remoteNow[key]['size']:
          logging.info(printMsg("REMOTE","  File size is different",key))
          _size=True
    
    
      if _newer or _older or _size or _deleted:
        remoteDeltas[key]=:
          'new':False,'newer':_newer,'older':_older,'size':_size,'deleted':_deleted
    
    
    
    for key in remoteNow:
      if key not in remotePrior:
        logging.info(printMsg("REMOTE","  File is new",key))
        remoteDeltas[key]=:
          'new':True,'newer':False,'older':False,'size':False,'deleted':False
    
    
    
    remoteDeltas=collections.OrderedDict(sorted(remoteDeltas.items()))
    if len(remoteDeltas)>0:
      news=newers=olders=deletes=0
      for key in remoteDeltas:
        if remoteDeltas[key]['new']:news+=1
        if remoteDeltas[key]['newer']:newers+=1
        if remoteDeltas[key]['older']:olders+=1
        if remoteDeltas[key]['deleted']:deletes+=1
    
      logging.warning("  {:4} file change(s) on REMOTE: {:4} new, {:4} newer, {:4} older, {:4} deleted".format(len(remoteDeltas),news,newers,olders,deletes))
    
    tooManyLocalDeletes=False
    if not force and float(localDeleted)/len(localPrior)>float(maxDelta)/100:
      logging.error("Excessive number of deletes (>{}%, {} of {}) found on the Local system {} - Aborting.  Run with --Force if desired."
      .format(maxDelta,localDeleted,len(localPrior),localPathBase))tooManyLocalDeletes=True
    
    tooManyRemoteDeletes=False
    if not force and float(remoteDeleted)/len(remotePrior)>float(maxDelta)/100:
      logging.error("Excessive number of deletes (>{}%, {} of {}) found on the Remote system {} - Aborting.  Run with --Force if desired."
      .format(maxDelta,remoteDeleted,len(remotePrior),remotePathBase))tooManyRemoteDeletes=True
    
    if tooManyLocalDeletes or tooManyRemoteDeletes:return RTN_ABORT
    if len(remoteDeltas)==0:
      logging.info(">>>>> No changes on Remote - Skipping ahead")
    
    else:
      logging.info(">>>>> Applying changes on Remote to Local")
    
    for key in remoteDeltas:
      if remoteDeltas[key]['new']:
        if key not in localNow:
          src=remotePathBase+key
          dest=localPathBase+key
          logging.info(printMsg("REMOTE","  Copying to local",dest))
          if rcloneCmd('copyto',src,dest,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
        else:
          src=remotePathBase+key
          dest=localPathBase+key+'_REMOTE'
          logging.warning(printMsg("WARNING","  Changed in both local and remote",key))
          logging.warning(printMsg("REMOTE","  Copying to local",dest))
          if rcloneCmd('copyto',src,dest,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
          src=localPathBase+key
          dest=localPathBase+key+'_LOCAL'
          logging.warning(printMsg("LOCAL","  Renaming local copy",dest))
          if rcloneCmd('moveto',src,dest,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
    
      if remoteDeltas[key]['newer']:
        if key not in localDeltas:
          src=remotePathBase+key
          dest=localPathBase+key
          logging.info(printMsg("REMOTE","  Copying to local",dest))
          if rcloneCmd('copyto',src,dest,options=["--ignore-times"]+switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
        else:
          if key in localNow:
            src=remotePathBase+key
            dest=localPathBase+key+'_REMOTE'
            logging.warning(printMsg("WARNING","  Changed in both local and remote",key))
            logging.warning(printMsg("REMOTE","  Copying to local",dest))
            if rcloneCmd('copyto',src,dest,options=["--ignore-times"]+switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
            src=localPathBase+key
            dest=localPathBase+key+'_LOCAL'
            logging.warning(printMsg("LOCAL","  Renaming local copy",dest))
            if rcloneCmd('moveto',src,dest,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
          else:
            src=remotePathBase+key
            dest=localPathBase+key
            logging.info(printMsg("REMOTE","  Copying to local",dest))
            if rcloneCmd('copyto',src,dest,options=["--ignore-times"]+switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
    
    
      if remoteDeltas[key]['deleted']:
        if key not in localDeltas:
          if key in localNow:
            src=localPathBase+key
            logging.info(printMsg("LOCAL","  Deleting file",src))
            if rcloneCmd('delete',src,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
    
    
    
    for key in localDeltas:
      if localDeltas[key]['deleted']:
        if(key in remoteDeltas)and(key in remoteNow):
          src=remotePathBase+key
          dest=localPathBase+key
          logging.warning(printMsg("WARNING","  Deleted locally and also changed remotely",key))
          logging.warning(printMsg("REMOTE","  Copying to local",dest))
          if rcloneCmd('copyto',src,dest,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
    
    
    if len(remoteDeltas)==0 and len(localDeltas)==0 and not firstSync:
      logging.info(">>>>> No changes on Local  - Skipping sync from Local to Remote")
    
    else:
      logging.info(">>>>> Synching Local to Remote")
      if rcloneCmd('sync',localPathBase,remotePathBase,options=excludes+switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
      logging.info(">>>>> rmdirs Remote")
      if rcloneCmd('rmdirs',remotePathBase,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
      logging.info(">>>>> rmdirs Local")
      if rcloneCmd('rmdirs',localPathBase,options=switches,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    
    logging.info(">>>>> Refreshing Local and Remote lsl files")
    os.remove(remoteListFileNew)
    os.remove(localListFileNew)
    if rcloneLSL(localPathBase,localListFile,excludes,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    if rcloneLSL(remotePathBase,remoteListFile,excludes,linenum=inspect.getframeinfo(inspect.currentframe()).lineno):return RTN_CRITICAL
    


  def loadList(self, infile):
    """
      Format ex:  3009805 2013-09-16 04:13:50.000000000 12 - Wait.mp3   541087
     2017-06-19 21:23:28.610000000 DSC02478.JPG    size  <----- datetime (epoch)
     ----> key return Success and a sorted list return False

    @param string infile : 
    @return string :
    @author
    """
    d=:
    
    
    try:
      with open(infile,'r')as f:
        for line in f:
          out=lineFormat.match(line)
          if out:
            size=out.group(1)
            date=out.group(2)
            _time=out.group(3)
            microsec=out.group(4)
            date_time=time.mktime(datetime.strptime(date+' '+_time,'%Y-%m-%d %H:%M:%S').timetuple())+float('.'+microsec)
            filename=out.group(5)
            d[filename]=:
              'size':size,'datetime':date_time
    
    
          else:
            logging.warning("Something wrong with this line (ignored) in {}:\n   <{}>".format(infile,line))
    
    
    
      return 0,collections.OrderedDict(sorted(d.items()))
    
    except:
      logging.error("Exception in loadList loading <{}>:  <{}>".format(infile,sys.exc_info()))
      return 1,""
    
    


  def requestLock(self, caller):
    """
      remove the \n

    @param string caller : 
    @return string :
    @author
    """
    for xx in range(5):
      if os.path.exists(lockfile):
        with open(lockfile)as fd:
          lockedBy=fd.read()
          logging.debug("{}.  Waiting a sec.".format(lockedBy[:-1]))
    
        time.sleep(1)
    
      else:
      with open(lockfile,'w')as fd:
        fd.write("Locked by {} at {}\n".format(caller,time.asctime(time.localtime())))
        logging.debug("LOCKed by {} at {}.".format(caller,time.asctime(time.localtime())))
    
      return 0
    
    logging.warning("Timed out waiting for LOCK file to be cleared.  {}".format(lockedBy))
    return-1
    


  def releaseLock(self, caller):
    """
     

    @param string caller : 
    @return string :
    @author
    """
    if os.path.exists(lockfile):
      with open(lockfile)as fd:
        lockedBy=fd.read()
        logging.debug("Removed lock file:  {}.".format(lockedBy))
    
      os.remove(lockfile)
      return 0
    
    else:
      logging.warning("<{}> attempted to remove /tmp/LOCK but the file does not exist.".format(caller))
      return-1
    
    




