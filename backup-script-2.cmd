@ECHO OFF

REM For net use authentication, destination server user and password
SET user=user
SET pass=password

REM Before running this code check the date format in windows and remove REM in below line where necessary

REM If date format is (dd-mmm-yy) then use below code by removing REM in below line
REM SET LOGFILE_DATE=%DATE%

REM If date format is (dd/mmm/yyyy) then use below code by removing REM in below line
REM SET LOGFILE_DATE=%DATE:~-4,4%-%DATE:~-8,3%-%DATE:~-11,2%

REM If date format is (m/dd/yyy) then use below code removing REM in below line
REM SET LOGFILE_DATE=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%

REM For avoiding space in time 
SET hour=%time:~0,2%
IF "%hour:~0,1%" == " " set hour=0%hour:~1,1%
SET min=%time:~3,2%
IF "%min:~0,1%" == " " set min=0%min:~1,1%
SET secs=%time:~6,2%
IF "%secs:~0,1%" == " " set secs=0%secs:~1,1%

SET LOGFILE_TIME=%hour%-%min%-%secs%

SET LOG_FILE=Backup_%LOGFILE_DATE%_%LOGFILE_TIME%.log

REM Source location is in Local Drive
SET SRC="Source_Location"

REM Destination location is in remote server
SET DEST="\\server\d$\dest_location"

REM Trying to connect using user and pass of remote destination
REM Redirect nul to suppress output as echo off don't work on net use 
REM Do not use DEST variable in net use command as it may not work
NET USE "\\server\d$\dest_location" /user:%user% %pass% >nul 


REM ATTENTION!!!! PURGE WILL DELETE FILE from DESTINATION as it will be a mirror image of source 
ROBOCOPY %SRC% %DEST% /E /PURGE /MT:20 /R:10 /Log:Log_location\%LOG_FILE%

REM Disconnecting network session for next use
net use "\\server\d$\dest_location" /delete /YES >nul
REM Done
