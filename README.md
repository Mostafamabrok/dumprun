# Dumprun
You run it, and it dumps.

This Repository was made for educational purposes.

### Important Usage Information
* All data collected by Dumprun is stored in the `dumped/` directory.
* The `dumped/` directory is created when `main.ps1` is executed.
* To run, execute `main.ps1` with powershell, or use the command in command.txt in the same directory.

### Dumped Data Table

All of the below data resides in the `dumped/` directory in the dumprun repo.

File or Folder  | Respective Command or Content
------------- | -------------
displaydns.txt  | ipconfig /displaydns
ipconfig.txt  | ipconfig
iplist.txt | arp -a
networkinfo.txt | network info
sysinfo.txt | systeminfo
tasklist.txt | tasklist
applist.txt | Names of the folders in the Program Files folder.
applist86.txt | Names of the folders in the Program Files (x86) folder.
keyinfo.txt | Contains some important system ans network information.
Chrome/ | All Google chrome data.
Edge/ | All MS Edge data.
wanted folder/ | all the contents of a folder inputed during execution.
