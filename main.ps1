mkdir dumped -Force
arp -a > dumped/iplist.txt 
ipconfig > dumped/ipconfig.txt 
ipconfig /displaydns > dumped/dnsdisplay.txt 
systeminfo > dumped/sysinfo.txt 