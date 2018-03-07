@ECHO OFF


REM For net use authentication, destination server user and password
SET user=user
SET pass=password

REM Setting date format legal for file name in windows 
SET LOGFILE_DATE=%DATE:~7,2%-%DATE:~4,2%-%DATE:~10,4%

REM For avoiding space in time 
SET hour=%time:~0,2%
IF "%hour:~0,1%" == " " set hour=0%hour:~1,1%
REM echo hour=%hour%
SET min=%time:~3,2%
IF "%min:~0,1%" == " " set min=0%min:~1,1%
REM echo min=%min%
SET secs=%time:~6,2%
IF "%secs:~0,1%" == " " set secs=0%secs:~1,1%
REM echo secs=%secs%

SET LOGFILE_TIME=%hour%-%min%-%secs%

REM echo %LOGILE_DATE% 
REM echo %LOGFILE_TIME%


SET LOG_FILE=Backup_%LOGFILE_DATE%_%LOGFILE_TIME%.log


SET SRC="Source_Location"
SET DEST="\\server\d$\dest_location"

REM Trying to connect using user and pass of remote destination
REM Redirect nul to suppress output as echo off don't work on net use 
NET USE "\\server\d$\dest_location" /user:%user% %pass% >nul 

ROBOCOPY %SRC% %DEST% /E /PURGE /MT:20 /R:10 /Log:Log_location\%LOG_FILE%


REM Deleting all netork mapping to clear session

REM echo ---------------------Closing----------------------------- >> %LOG_LOCATION%%LOGFILE%
REM echo Disconnecting all network session... >> %LOG_LOCATION%%LOGFILE%
net use "\\server\d$\dest_location" /delete /YES >nul
REM echo Done! >> %LOG_LOCATION%%LOGFILE%
