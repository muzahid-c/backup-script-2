@ECHO OFF

REM For net use authentication, destination server user and password
SET user=user
SET pass=password

REM Setting date format legal for file name in windows 
SET LOGFILE_DATE=%DATE:~7,2%-%DATE:~4,2%-%DATE:~10,4%

REM For avoiding space in time 
SET hour=%time:~0,2%
IF "%hour:~0,1%" == " " set hour=0%hour:~1,1%
SET min=%time:~3,2%
IF "%min:~0,1%" == " " set min=0%min:~1,1%
SET secs=%time:~6,2%
IF "%secs:~0,1%" == " " set secs=0%secs:~1,1%

SET LOGFILE_TIME=%hour%-%min%-%secs%

SET LOG_FILE=Backup_%LOGFILE_DATE%_%LOGFILE_TIME%.log

SET SRC="Source_Location"
SET DEST="\\server\d$\dest_location"

REM Trying to connect using user and pass of remote destination
REM Redirect nul to suppress output as echo off don't work on net use 
REM Do not use DEST variable in net use command as it may not work
NET USE "\\server\d$\dest_location" /user:%user% %pass% >nul 

ROBOCOPY %SRC% %DEST% /E /PURGE /MT:20 /R:10 /Log:Log_location\%LOG_FILE%

REM Disconnecting network session for next use
net use "\\server\d$\dest_location" /delete /YES >nul
REM Done
