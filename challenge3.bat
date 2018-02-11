:: challenge3.bat
:: Using netcat, port scan only the following:
::	TCP 21
::	TCP 22
::	TCP 23
::	TCP 25
::	TCP 53
::	TCP 80
::	TCP 135
::	TCP 443
::	TCP 6000

@echo off

:: Default Vars
set portsFile=challenge3-ports.txt
set target=192.168.1.1

:: Append list of ports to file
call echo 21 > %portsFile%
call echo 22 >> %portsFile%
call echo 23 >> %portsFile%
call echo 25 >> %portsFile%
call echo 53 >> %portsFile%
call echo 80 >> %portsFile%
call echo 135 >> %portsFile%
call echo 443 >> %portsFile%
call echo 6000 >> %portsFile%


for /F %%i in (%portsFile%) do @nc.exe -n -vv -w3 %target% %%i
