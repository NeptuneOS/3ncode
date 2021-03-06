#!/usr/bin/python
# ################################
# Encode 3
# by Leszek Lesner
# released under the terms of BSD (3-clause)
# ################################ 
import sys
global use_pyside

try:
  # Try importing PyQt4 if available (i.e. on Desktop)
  from PyQt4.QtCore import QTimer, QObject, QUrl, QCoreApplication, SIGNAL,QTranslator, QProcess, SLOT, pyqtSlot, QString
  from PyQt4.QtGui import QApplication, QDesktopWidget, QFileDialog, QMessageBox, QIcon, QPalette
  from PyQt4.QtDeclarative import QDeclarativeView
  use_pyside = False
except:
  print "PyQt4 failed to load, trying to use PySide instead..."
  try:
    # If PyQt4 could not be loaded use PySide (i.e. very useful for N900 and Maemo)
    from PySide.QtCore import QTimer, QObject, QUrl, QCoreApplication, SIGNAL,QTranslator, QProcess, SLOT, pyqtSlot, QString
    from PySide.QtGui import QApplication, QDesktopWidget, QFileDialog, QMessageBox, QIcon, QPalette
    from PySide.QtDeclarative import QDeclarativeView
    print "success."
    use_pyside = True
  except:
    print "failed."
    print "Please install either PyQt4 or PySide for this application to run successfully."
    sys.exit(1) 

#from PyKDE4.plasma import *  
    
class MyQProcess(QProcess):     
  def __init__(self):    
   #Call base class method 
   QProcess.__init__(self)
   
  @pyqtSlot()
  def finishEncode(self):
   #rootObject.hideEncodeAnimation()
   #print str(outputfile)
   #print cmdProcess.exitCode()
   if path.exists(unicode(outputfile.toUtf8(), "utf-8")) and (cmdProcess.exitCode() == 0 or cmdProcess.exitCode() == 255):
     print "File encoded successfully"
     rootObject.successEncode()
   else:
     print "Encoding error"
     rootObject.showError("Encoding file " + outputfile + " failed")
   #self.close()
   
  @pyqtSlot()
  def errorEncode(self):
   print "error occured" 
   rootObject.hideEncodeAnimation()
   rootObject.showError(QString.fromAscii(self.readAllStandardError()))
   self.close()
   
  @pyqtSlot()
  def readStdOutput(self):
   #print self.readAllStandardOutput()
   open(home + "/encode.log","a").write(self.readAllStandardOutput()) 
   
  @pyqtSlot()
  def readStdError(self):
   #print self.readAllStandardError()
   rAsE = self.readAllStandardError()
   open(home + "/encode.log", "a").write(rAsE)
    
    
def quit():
  sys.exit(0)
  
def openLog():
  popen("xdg-open " + home + "/encode.log")
  
def openFile():
  transObj = QObject()
  fName = QFileDialog.getOpenFileName(None, transObj.tr("Open media file"), home, transObj.tr("Media Files (*.mp4 *.avi *.mp3 *.wav *.ogg *.flv *.ogv *.m4v *.m4a *.aac *.flac *.webm *.mpg *.mpeg *.wmv *.wma *.mp2 *.mov *.oga *.aif *.aiff *.aifc *.ape *.mka *.asf *.3gp *.dv *.m2t *.mts *.ts *.divx *.nsv *.ogm)"))
  if fName.isEmpty() == False:
    rootObject.sourceFilename(fName)
    
def openF(filename):
    rootObject.sourceFilename(filename)
    
def saveFile(filename):
  transObj = QObject()
  fName = QFileDialog.getSaveFileName(None, transObj.tr("Save media file"), filename, "")
  if fName.isEmpty() == False:
    rootObject.targetFilename(fName)  
    
def encodeCmd(cmd,outfile):
  # First check if outfile exists already
  #print unicode(outfile.toUtf8(), "utf-8")
  if path.exists(unicode(outfile.toUtf8(), "utf-8")): 
    print "File exists ask if you want to overwrite it"
    reply = QMessageBox.question(None, 'Message',
            "The file " + outfile + " already exists. Do you want to overwrite it ?", QMessageBox.Yes | 
            QMessageBox.No, QMessageBox.No)

    if reply == QMessageBox.Yes:
      remove(unicode(outfile.toUtf8(), "utf-8"))
    else:
      return
    
  global outputfile
  outputfile = outfile
  
  # Write command to history file
  popen("echo \"" + unicode(cmd.toUtf8(), "utf-8").encode("utf-8") + "\" >> ~/encode_history.log") 
  # Execute command
  #popen("xterm -T \"Encoding...\" -b 5 -e \"" + str(cmd) +  " 2>&1 | tee ~/encode.log\" &")
  rootObject.showEncodeAnimaton()
  # If I ever figure out how to do this I tell you
  #cmdProcess.setProcessChannelMode(QProcess.MergedChannels)
  #cmdProcess.startDetached(cmd) # + " | tee -a ~/encode.log")
  # Clean the log before writing to it again
  open(home + "/encode.log", "a").write("")
  cmdProcess.start(cmd) # + " | tee -a ~/encode.log")
  
def abortEncode():
  cmdProcess.terminate()

# Import popen to execute shell commands, 
# path for working with standard paths 
# ConfigParser for config handling
# and time for time and date handling
from os import popen, path, remove
#import ConfigParser, time
home = path.expanduser("~")

app = QApplication(sys.argv)
app.setGraphicsSystem("raster")
app.setWindowIcon(QIcon('qml/img/encode.png'))

defaultBgColor=app.palette().color(QPalette.Window).name()
#Plasma.Theme.defaultTheme().setUseGlobalSettings(False)
#Plasma.Theme.defaultTheme().setThemeName("AirNeptune")
#Plasma::Theme::defaultTheme()->setUseGlobalSettings(false); //don't change every plasma theme!
#Plasma::Theme::defaultTheme()->setThemeName("appdashboard");

# Create the QML user interface.
view = QDeclarativeView()
# Use PlasmaComponents
engine = view.engine()
engine.addImportPath("/usr/lib/kde4/imports")
# Set main qml here
view.setSource(QUrl("3ncode.qml"))
view.setResizeMode(QDeclarativeView.SizeRootObjectToView)

# Get the root object of the user interface.
rootObject = view.rootObject()

# Set default background
rootObject.setBgColor(defaultBgColor)

# Check for parameters
if len(sys.argv) > 1:
  openF(str(sys.argv[1]).decode('utf-8'))

# Connect QML signals with Python functions
rootObject.openFile.connect(openFile)
rootObject.saveFile.connect(saveFile)
rootObject.encodeCmd.connect(encodeCmd)
rootObject.abortEncode.connect(abortEncode)
rootObject.openLogClicked.connect(openLog)

# Set home dir in qml
rootObject.setHomeDir(home)

# Create encode process
cmdProcess = MyQProcess()
QObject.connect(cmdProcess,SIGNAL("finished(int)"),cmdProcess,SLOT("finishEncode()"))
QObject.connect(cmdProcess,SIGNAL("readyReadStandardOutput()"),cmdProcess,SLOT("readStdOutput()"))
QObject.connect(cmdProcess,SIGNAL("readyReadStandardError()"),cmdProcess,SLOT("readStdError()"))
QObject.connect(cmdProcess,SIGNAL("error()"),cmdProcess,SLOT("errorEncode()"))

# Outputfile
outputfile = QString("empty")

# Display the user interface and allow the user to interact with it.
view.setGeometry(0, 0, 480, 575)
view.setFixedSize(480, 575) 
view.setWindowTitle(QCoreApplication.translate(None, 'Encode'))
screen = QDesktopWidget().screenGeometry()
size =  view.geometry()
view.move((screen.width()-size.width())/2, (screen.height()-size.height())/2)
view.show()
#view.showFullScreen()

app.exec_()

