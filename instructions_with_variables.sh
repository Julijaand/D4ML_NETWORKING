# IPv4 CIDR
# 172.31.32.0/20

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