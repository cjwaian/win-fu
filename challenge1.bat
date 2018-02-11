:: challenge1.bat
:: Determine who the script is running as
:: Get list of all users, determine all administrators
:: Create new user, add them to administrators group
:: Launch shell as the new user, use whoami to verify
:: Clean up, remove new user from administrators group
:: Delete new user from system
:: Print list of all users & administrators group membership
::  along the way so we can see the changes happening


:: This is ugly, I don't know how to batch ... better solutions?
:: How do you var=$(command) like in bash?



@echo off

:: Default Vars
set newuser=Test
set newuserpass=correct horse battery staple



:: Determine what user & domain this script is running as
:: from cmd.exe use "set username" to print the enviromental variable
:: In a batch script, these enviromental variables are already set
:: we just need to access them using %ENV_VAR%
set user=%USERNAME%
echo Username: %user%

set domain=%USERDOMAIN%
echo Domain: %domain%
echo.
echo.
echo.



echo Whoami:
:: "whoami" is also possible
set whoami=whoami
call %whoami%
echo.
echo.
echo.



echo All local users:
:: Get list of all users using "net user" cmd
set allusers=net user
call %allusers%
echo.
echo.
echo.



echo Users in the Administrators group:
:: List all users in the administrators group
set adminusers=net localgroup administrators
call %adminusers%
echo.
echo.
echo.



echo Creating Test User: %newuser%
:: Create a new user
set createuser=net user %newuser% "%newuserpass%" /add /y
call %createuser%
echo.
echo.
echo.



echo Adding User %newuser% to Administrators group
:: Adding new user to Administrators group
set addusertogrp=net localgroup administrators %newuser% /add
call %addusertogrp%
echo.
echo.
echo.



echo All local users:
:: Get list of all users using "net user" cmd
set allusers=net user
call %allusers%
echo.
echo.
echo.



echo Users in the Administrators group:
:: List all users in the administrators group
set adminusers=net localgroup administrators
call %adminusers%
echo.
echo.
echo.



echo Launch cmd.exe as user %newuser
call runas /u:%newuser% cmd.exe & pause
echo.
echo.
echo.



echo Removing User %newuser% from Administrators group
:: Removing new user from Administrators group
set removeuserfromgrp=net localgroup administrators %newuser% /del
call %removeuserfromgrp%
echo.
echo.
echo.



echo Deleting Test User: %newuser%
:: Deleting new user
set deleteuser=net user %newuser% /del /y
call %deleteuser%
echo.
echo.
echo.



echo All local users:
:: Get list of all users using "net user" cmd
set allusers=net user
call %allusers%
echo.
echo.
echo.



echo Users in the Administrators group:
:: List all users in the administrators group
set adminusers=net localgroup administrators
call %adminusers%
echo.
echo.
echo.
