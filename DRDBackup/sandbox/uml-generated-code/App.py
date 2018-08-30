# coding=UTF-8

class App(object):

  """
   

  :version:
  :author:
  """

  def shell(self):
    """
     

    @return  :
    @author
    """
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


  def quit(self):
    """
     

    @return  :
    @author
    """
    pass

  def start(self):
    """
     

    @return  :
    @author
    """
    pass



