# win-fu #
Windows Command Line Notes
-Command Line Utilities
-One Liners
-Display Contents of Files
-Enviromental Variables

***




### Command Line Utilities ###
List current TCP/UDP port usage.
```
Windows:    netstat -na
Linux:      netstat -tuplen
```

Shows arp cache. Entries are the systems which the host has sent packets to in the last 10 minutes.
```
Windows:    arp -a
Linux:      arp -a
```

Shows routing tables.
```
Windows:    netstat -nr
Linux:      netstat -nr
Linux:      ip route
Linux:      route -n
```

Shows recently resolved domain names. Is there a linux equivalent?? would love to know!!
```
Windows:    ipconfig /displaydns
```

What user am I logged in as? Windows command only works on cmd.exe not powershell. Windows also does not include the python-pwd module. _see Enviromental Variables_. 
```
Linux:      whoami
Windows:    set username
python:     pwd.getpwuid(os.getuid())[0]
python:     getpass.getuser()
python:     os.environ.get('USERNAME')
```

Display current users path. _see Enviromental Variables_. 
```
Linux:      printenv PATH
SH/Bash:    echo $PATH
Windows:    set path
python:     os.environ.get('PATH')
```

---

### One Liners ###
List all installed software/packages.
```
Windows:    dir /s "C:\Program Files"
Linux (apt):      apt list --installed
Linux (yum):      yum list installed
```

---

### Display Contents of Files ###
Display the contents of a file, equivalent to linux `cat`.
```
Windows:    type [path/to/file]
Linux:      cat [path/to/file]
```

Display the contents of multiple files using a wildcard in the filename.
```
Windows:    type *.[file extension]    ie:  type *.txt
Linux:      cat *.[file extension]
```

Dispaly the contents of multiple files by passing multiple arguments (file names/paths) to the command.
```
Windows:    type [path/to/File-A] [path/to/File-B]
Linux:      cat [path/to/File-A] [path/to/File-B]
```

Display only a snipet of a file with the option to scroll through the remaining contents.
```
Windows:    more [path/to/file]
Linux:      more [path/to/file]
```

Display only the lines from a file which contain a certain string. Windows command only works on cmd.exe not powershell, is there a equivalent command for powershell (_see next_)?
```
Windows:    type [path/to/file] | find /i "[string]"
Linux:      cat [path/to/file] | grep "[string]"
```

Display only the lines from a file which contain a certain regex. Windows command works in powershell.
```
Windows:    type [path/to/file] | findstr "[regex]"
Linux:      cat [path/to/file] | grep "[regex]"
```

Display contents of a file continuously, will update if new lines are written to it. Is there a equivalent Windows command? Linux Only, had to note it because its so awesome.
```
Linux:      tail -f [path/to/file]
```

---

### Enviromental Variables ###
Display all enviromental variables
```
Windows:    set
Linux:      set
Linux:      env
Linux:      printenv
python:     print os.environ     <--- returns dict
```

Display a specific enviromental variable such as `username` or `path`.
```
Windows:    set [env_key]
Linux:      printenv [env_key]
python:     print os.environ.get("[env_key]")
SH/Bash:    echo $[env_key]
```


Set a enviromental variable; not persistent.
```
Windows:    set [env_key]=[env_value]
Linux:      env [env_key]=[env_value]
Linux:      export [env_key]=[env_value]
python:     os.environ[env_key]=[env_value]
SH/Bash:    [env_key]=[env_value]
```
