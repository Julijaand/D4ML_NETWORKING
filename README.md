#Task
As DevOps engineer you need to perform next steps to make more secure our local Mail server with help of Iptables Firewall.

Description:

Keep in mind that IP Addresses could be changed. Show them in your description. For example if your Subnet in AWS have 10.0.0.0/8 CIDR then use IP Addresses from it.

Local subnet is 192.168.42.0/24
Mail server ip: 192.168.42.11
NAT Gateway ip: 192.168.42.255
IT department IP range 192.168.42.200-220
HR department IP range 192.168.42.150-199
Backup server IP: 192.168.42.250
Local DNS server IP: 192.168.42.251

25 port TCP of mail server should accept connections from internet.
53 port TCP\UDP should be open for outbound connections for DNS use
143 TCP port of mail server must be closed for any connection
993 TCP port should be opened for HR department and Backup server connection
465 TCP port could be accessed by IT department only
587 TCP port must be opened for HR and IT departments only
Each evening Backup server used SMB default port to get mail backups from Mail server
SSH default port of Mail server should be available for IT department.
all other ports, except 443, should be restricted

#Instructions
IPv4 CIDR:
172.31.32.0/20

Mail server IP: 172.31.32.11
NAT Gateway IP: 172.31.47.255
IT department IP range: 172.31.32.200-172.31.32.220
HR department IP range: 172.31.32.150-172.31.32.199
Backup server IP: 172.31.32.250
Local DNS server IP: 172.31.32.251

$ sudo apt-get install iptables 					- update/install iptables
$ sudo iptables -L						            - show all iptables
$ sudo iptables -F				                    - clear all the currently configured rules

#Task 1
25 port TCP of mail server should accept connections from internet:
$ sudo iptables -A INPUT -p tcp --dport 25 -j ACCEPT

#Task 2
53 port TCP\UDP should be open for outbound connections for DNS use:
$ sudo iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
$ sudo iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

#Task 3
143 TCP port of mail server must be closed for any connection:
$ sudo iptables -A INPUT -p tcp --dport 143 -j DROP

#Task 4
993 TCP port should be opened for HR department and Backup server connection:
$ sudo iptables -A INPUT -p tcp --dport 993 -m iprange --src-range "$HR_DEPARTMENT_RANGE" -j ACCEPT
$ sudo iptables -A INPUT -p tcp --dport 993 -s "$BACKUP_SERVER" -j ACCEPT

#Task 5
465 TCP port could be accessed by IT department only
$ sudo iptables -A INPUT -p tcp --dport 465 -m iprange --src-range "$IT_DEPARTMENT_RANGE" -j ACCEPT

#Task 6
587 TCP port must be opened for HR and IT departments only
$ sudo iptables -A INPUT -p tcp --dport 587 -m iprange --src-range "$HR_DEPARTMENT_RANGE" -j ACCEPT
$ sudo iptables -A INPUT -p tcp --dport 587 -m iprange --src-range "$IT_DEPARTMENT_RANGE" -j ACCEPT

#Task 7
Each evening Backup server used SMB default port to get mail backups from Mail server
$ sudo iptables -A INPUT -p tcp --dport 445 -s "$BACKUP_SERVER" -j ACCEPT

#Task 8
SSH default port of Mail server should be available for IT department.
$ sudo iptables -A INPUT -p tcp --dport 22 -m iprange --src-range "$IT_DEPARTMENT_RANGE" -j ACCEPT

#Task 9
all other ports, except 443, should be restricted
$ sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
$ sudo iptables -A INPUT -j DROP

$ sudo iptables-save > /etc/iptables/rules.v4    - save iptables rules in separate file
$ sudo iptables -L						         - show all iptables
