mkdir dumped -Force #All collected data is stored in here.
mkdir dumped/edge -Force #All the MS edge data is stored here.
mkdir dumped/chrome -Force #All Google Chrome data is stored here.
mkdir dumped/wantedfolder -Force #Desired Path contents are stored here.
Write-Host "Created Dumped directories. `n"

Write-Host "Dumprun Data Collection Software, Developed By MSTF Studios.`n"

Write-Host "Starting Dumprun data collection software pre-run configuration."
$quick_run_permission=Read-Host "Would you like to quick run? (y/n)"

if ($quick_run_permission -eq "n"){
    $copy_permission=Read-Host "Would you like copy a folder during running? (y/n)"
    $key_info_permission=Read-Host "Would you like a keyinfo.txt file to be generated? (y/n)"
    $browser_data_permisson=Read-Host "Would you like to extract browser data? (y/n)"
    Write-Host "Configuration Complete. Initiating data collection"
}

if ($quick_run_permission -eq "y"){
    $copy_permission="n"
    $key_info_permission="n"
    $browser_data_permisson="n"
}

#Below is just standard system and network info.
arp -a > dumped/iplist.txt
ipconfig > dumped/ipconfig.txt ; Write-Host "Retreived Ipconfig"
ipconfig /displaydns > dumped/dnsdisplay.txt; Write-Host "Retreived Ipconfig/displaydns"
systeminfo > dumped/sysinfo.txt ; Write-Host "Retreived Sysinfo"
tasklist > dumped/tasklist.txt; Write-Host "Retreived Tasklist"
Get-Clipboard > dumped/clipboard.txt; Write-Host "Retreived Clipboard"
Get-ChildItem -Path "C:\Program Files" | Select-Object Name > dumped/applist.txt
Get-ChildItem -Path "C:\Program Files (x86)" | Select-Object Name > dumped/applist86.txt
$ip_address=ipconfig | findstr "IPv4"


#This gets network information by checking the network name and getting the info based on that.
$networkname=Get-NetConnectionProfile | Select-Object -ExpandProperty Name 
$networkpassword=Netsh wlan show profile name=$networkname key=clear |findstr "Key Content"
Netsh wlan show profile name=$networkname key=clear > dumped/networkinfo.txt


if ($copy_permission -eq "y") {
    #Asks user for desired path to copy and then copies it and its contents.
    Write-Output "Write your desired path to copy:"
    $wantedpath=Read-Host
    $wantedcopy="dumped/wantedfolder"
    Copy-Item -Path $wantedpath -Destination $wantedcopy -Recurse -Force -ErrorAction Continue
    Write-Host "Copied Directory"
}

if ($copy_permission -eq "n"){
    Write-Host "Continuing on with the program.`n"
}


if ($key_info_permission -eq "y"){
    "User name: $Env:UserName" > dumped/keyinfo.txt
    "Network name: $networkname" >> dumped/keyinfo.txt
    "Network Password: $networkpassword" >> dumped/keyinfo.txt
    "IP:$ip_address" >>dumped/keyinfo.txt 
    Write-Host "Keyinfo Document retreived."
}

if ($browser_data_permisson -eq "y"){
try {
    #This command copies edge history data to dumped/edge
    $source_path_edge="C:\Users\$Env:UserName\AppData\Local\Microsoft\Edge\User Data\Default"
    $destination_path_edge="dumped\edge"
    Write-Host "Retreiving Edge Data..."
    Copy-Item -Path $source_path_edge -Destination $destination_path_edge -Recurse -Force -ErrorAction Stop
    Write-Host "Collected Edge Browsing History `n" 
}
catch {
    Write-Host "Edge Is not installed on this device, or the history folder is not available.`n"
}

#The reason we make the error action stop for the history data retreivers is so try catch can catch them and write a message.

try {
    #This command copies chrome history data to dumped/chrome.
    $source_path_chrome="C:\Users\$Env:UserName\AppData\Local\Google\Chrome\User Data\Default"
    $destination_path_chrome="dumped\chrome"
    Write-Host "Retreiving Chrome Data..."
    Copy-Item -Path $source_path_chrome -Destination $destination_path_chrome -Recurse -Force -ErrorAction Stop
    Write-Host "Collected Chrome Browsing History `n"
}
catch {
    Write-Host "Google Chrome is not installed on this device, or the history folder is not available."
}
}

Write-Host "`nData Collection complete."