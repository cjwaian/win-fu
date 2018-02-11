:: challenge2.bat
:: Write a for loop that will do reverse dns lookups of each ip in a /24

:: Default Vars
set net=192.168.1.
set dnsserver=192.168.1.1

for /L %%i in (1,1,255) do @nslookup %net%%%i %dnsserver% 2>nul | find "Name" && echo %net%%%i
