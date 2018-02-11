# win-fu #
Windows Command Line Notes

-Command Line Utilities

-One Liners

-Display Contents of Files

-Enviromental Variables

- Accounts and Groups



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
Windows:        dir /s "C:\Program Files"
Linux (apt):    apt list --installed
Linux (yum):    yum list installed
```

Ping Sweep a `/24` network.
```
Windows:    for /L  %i in (1,1,255) do @ping -n 1 192.168.1.%i | find "TTL"

Linux:      i=1; while [ $i -le 255 ]; do ping -c 1 192.168.1.$i | grep ttl; i=$(( $i + 1 )); done;

Bash:       i=1
            while [ $i -le 255 ]
            do
                ping -c1 192.168.1.$i | grep ttl
                i=$(( $i + 1 ))
            done
```

Read through a file containing a list of passwords and attempt to initialize an SMB session while trying each password.
```
Windows:    for /f %i in ([path/to/file]) do @echo %i & @net use \\[remote_ip] %i /u:[username] 2>nul && pause
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

### Filter Command Output ###
Filter the output of a command, show results only if `string` is containted in the output.
```
Windows:    @[command] | find "[string]"
Linux:      [command] | grep "[string]"
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

---

### Accounts and Groups ###
List all local users on a system.
```
Windows:    net user
Linux:      cat /etc/passwd
Linux:      cut -d: -f1 /etc/passwd
```

List all local groups on a system.
```
Windows:    net localgroup
Linux:      cat /etc/group
Linux:      cut -d: -f1 /etc/group
```

List all members of a group. Linux doesn't have great options.
```
Windows:    net localgroup [group_name]
Linux:      getent group [group_name]
```

Create user and set password.
```
Windows:    net user [username] [passwd] /add
Linux:      adduser [username]
             passwd [username]
```

Add user to group.
```
Windows:    net localgroup [group_name] [username] /add
Linux:      usermod -aG [group_name] [username]
```

Remove user.
```
Windows:    net user [username] /del
Linux:      userdel [username]
```

Remove user from group.
```
Windows:    net localgroup [group_name] [username] /del
Linux:      userdel [username] [group_name]
Linux:      gpasswd -d [username] [group_name]
```

---

### Firewall ###
Show all firewall rules for all profiles.
```
Windows:    netsh advfirewall show allprofiles
Linux:      iptables -t filter -L
Linux:      firewall-cmd --list-ports
Linux:      firewall-cmd --list-services
```

Add firewall rule to allow inbound connection.
```
Windows:    netsh advfirewall firewall add rule name="[rule_name]" dir=in action=allow remoteip=[?optional?] protocol=TCP localport=[port]

Linux:      iptables -A INPUT -p tcp --dport [port] -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
            iptables -A OUTPUT -p tcp --sport [port] -m conntrack --ctstate ESTABLISHED -j ACCEPT

Linux:      firewall-cmd --zone=[public] --add-port=[port]/tcp    (--permanent)
            firewall-cmd --zone=[public] --add-service=[service_name]     (--permanent)
            firewall-cmd --reload
```


Remove firewall rules.
```
Windows:    netsh advfirewall firewall del rule name="[rule_name]"

Linux:      iptables -D INPUT -p tcp --dport [port] -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
            iptables -D OUTPUT -p tcp --sport [port] -m conntrack --ctstate ESTABLISHED -j ACCEPT

Linux:      firewall-cmd --zone=[public] --remove-port=[port]/tcp    (--permanent)
            firewall-cmd --zone=[public] --remove-service=[service_name]     (--permanent)
            firewall-cmd --reload
```

Disable firewall.
```
Windows:    netsh advfirewall set allprofiles state off
```

---

### Registry ###
Search registry by key.
```
reg query [key_name]
```

Create and/or Modify registry key/values by key.
```
reg add [key_name] /v [key_value] /t [type] /d [data]
```

Export registry settings to files.
```
reg export [key_name] [path/to/file.reg]
```

Import to registry.
```
reg import [path/to/file.reg]
```

Remotely interact with another systems registry over SMB.
```
reg query \\[remote_system] [key_name]
reg add \\[remote_system] [key_name] /v [key_value] /t [type] /d [data]
reg export \\[remote_system] [key_name] [path/to/file.reg]
reg import \\[remote_system] [path/to/file.reg]
```

---

### SMB ###
Note: only one SMB session permitted to the same remote system at a time.
Initialize SMB session.
```
net use \\[remote_ip] [password] /u:[username]
```

Mount share over SMB.
```
net use * \\[remote_ip]\[share] [password] /u:[username]
```

Drop SMB session.
```
net use \\[remote_ip] /del
```

Drop all SMB session.
```
net use * /del /y
```

---

### Services ###
Run against a remote system by adding `sc \\[remote_ip]` before all commands; over SMB session.
```
Windows:    sc \\[remote_ip] query
Windows:    sc \\[remote_ip] query state=all
Windows:    sc \\[remote_ip] qc [service_name]
```

List _ALL_ services.
```
Windows:    sc query state=all
Linux:      ps -A
Linux:      systemctl list-unit-files
```

List all running services.
```
Windows:    sc query
Linux:      ps aux | less
```

Get service status.
```
Windows:    sc qc [service_name]
Linux:      systemctl status [service_name]
```

Start status.
```
Windows:    sc start [service_name]
Linux:      systemctl start [service_name]
```

Enable status.
```
Windows:    sc config [service_name] start=demand
Linux:      systemctl enable [service_name]
```

Stop status.
```
Windows:    sc stop [service_name]
Linux:      systemctl stop [service_name]
```

---

### Sleep ###
The `/t` specifies number of seconds to wait.
```
Windows:    timeout /t 4
Linux:      sleep 4
Python:     time.sleep(4)
```

Prevent stop (`CTL+C`) with `/nobreak`.
```
Windows:    timeout /t 4 /nobreak
```

---

### Chain Commands ###
Run second command always, even if the first command fails.
```
Windows:    [first_command] & [second_command]
Linux:      [first_command] || [second_command]
```
Run second command only if first command succeeds.
```
Windows:    [first_command] && [second_command]
Linux:      [first_command] && [second_command]
```

---

### Piping Stderr ###
Redirect Stderr to Stdout, then write to file.
```
Windows:    [command] 2>> error.log
Linux:      [command] >> error.log 2>&1
```
Bash notes: https://www.tldp.org/LDP/abs/html/io-redirection.html
---

### Echo Off ###
Do not display `echo` stdout.
```
Windows:    @echo [string]
```
Why would you want to do that? Why not just remove the `echo` statement?

---

### Dev Null ###
```
Windows:    echo "Hello World" > nul
Linux:      echo "Hello World" >> /dev/null
```

---

### Newline Character ###
Print a newline character.
```
Windows:    echo.
Linux:      echo "\n"
```

---

### For Loop (While) ###
`FOR /L` = More like a while loop with an incremented variable...
Construction: `for /L %i ([start],[increment],[stop]) do [command]`
Exmaples:
```
Windows:    for /L %i in (1,1,255) do echo %i

Python:     i=1
            while i < 255:
                  print i
                  i+=1

Bash:       i=1
            while [ $i -le 255 ]
            do
                echo $i
                i=$(( $i + 1 ))
            done
```

---

### For Each Loop ###
`FOR /F` = For each loop
Construction: `for /F [options] %i in ([data]) do [command]`
Exmaples:
```
Windows:    for /F %i in ([data]) do echo %i

Python:     for i in [data]:
                print i

Bash:       for i in [data]
                 echo %i
            done
```

---

### Batch File Vars ###
Temporary variables such as `%i` must be written as `%%i` if running from a `.bat` file. This is because command like args are represented as `%1`,`%2`,`%3` ect.
```
Windows:    for /F %%i in ([data]) do echo %%i
```
https://stackoverflow.com/questions/14509652/what-is-the-difference-between-and-in-a-cmd-file

---

### Command Line Args ###
Parameters passed to a script from the commandline can be retrieved within the script by invoking special variables.
```
Windows:    example.bat [arg]
            echo %1

Python:     example.py [arg]
            print sys.argv[1]

Bash:       example.sh [arg]
            echo $1
```
