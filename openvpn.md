# openvpn
## howto 一键安装
https://github.com/angristan/openvpn-install
https://www.cyberciti.biz/faq/debian-10-set-up-openvpn-server-in-5-minutes/
wget https://raw.githubusercontent.com/Angristan/openvpn-install/master/openvpn-install.sh

# 同时跑tcp udp 2 instances
ln -s /usr/sbin/openvpn /usr/sbin/openvpn2
cd /etc/openvpn
cp server.conf server2.conf
port
proto tcp
dev tun1
server 10.9.0.0 255.255.255.0   // 保证和udp的不一样
status  // 保证唯一
## run foreground
/usr/sbin/openvpn2 --cd /etc/openvpn --config /etc/openvpn/server2.conf
## run background
/usr/sbin/openvpn2 --daemon --cd /etc/openvpn --config /etc/openvpn/server2.conf
## create iptables rules 设置转发规则
apt-get install -y iptables dnsutils
### iptables设置加入 /etc/iptables/add-openvpn-rules.sh 和 /etc/iptables/rm-openvpn-rules.sh
iptables -t nat -I POSTROUTING 1 -s 10.9.0.0/24 -o eth0 -j MASQUERADE
iptables -I INPUT 1 -i tun1 -j ACCEPT
iptables -I FORWARD 1 -i eth0 -o tun1 -j ACCEPT
iptables -I FORWARD 1 -i tun1 -o eth0 -j ACCEPT
iptables -I INPUT 1 -i eth0 -p tcp --dport 52619 -j ACCEPT
删除规则 -I 改成 -D 去掉1
## 查看 check iptable
iptables -S
iptables -L -v -n
## run as service
cd /lib/systemd/system/
vim openvpn2.service
systemctl daemon-reload
systemctl enable openvpn2
service openvpn2 start

[Unit]
Description=OpenVPN2 service
After=network.target

[Service]
Type=simple
ExecStart=/usr/sbin/openvpn2 --cd /etc/openvpn --config /etc/openvpn/server2.conf
Restart=always
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target


# 修改端口 change port
systemctl list-unit-files --state=enabled | grep openvpn
iptables-openvpn.service                    enabled
openvpn-server@.service                     enabled
service iptables-openvpn.service status
cat /etc/systemd/system/iptables-openvpn.service
## 除了更改 /etc/openvpn/server.conf 还要更改这两个脚本
/etc/iptables/add-openvpn-rules.sh
/etc/iptables/rm-openvpn-rules.sh


# Debian client openvpn3
https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/
apt-get install -y gnupg2 apt-transport-https
wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
apt-key add openvpn-repo-pkg-key.pub
wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-buster.list
apt-get update
apt-get install -y openvpn3

apt-get install -y openvpn
openvpn --config xx.ovpn
## run in docker
docker run --cap-add=NET_ADMIN --device=/dev/net/tun -d -v `pwd`:/share --name "test" rtmp:20201115 /usr/bin/supervisord
--privileged
--cap-add=NET_RAW
## add to .ovpn for dns url resolv url解析
script-security 2
up /etc/openvpn/update-resolv-conf
down /etc/openvpn/update-resolv-conf

# install shadowsocks
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log

# server.conf
port 11194
proto udp
dev tun
user nobody
group nobody
persist-key
persist-tun
keepalive 10 120
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "dhcp-option DNS 176.103.130.130"
push "dhcp-option DNS 176.103.130.131"
push "redirect-gateway def1 bypass-dhcp"
dh none
ecdh-curve prime256v1
tls-crypt tls-crypt.key
crl-verify crl.pem
ca ca.crt
cert server_1JnU1kNRHl255oeU.crt
key server_1JnU1kNRHl255oeU.key
auth SHA256
cipher AES-128-GCM
ncp-ciphers AES-128-GCM
tls-server
tls-version-min 1.2
tls-cipher TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256
client-config-dir /etc/openvpn/ccd
status /var/log/openvpn/status.log
verb 3

# route before
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.50.1    0.0.0.0         UG    0      0        0 eth0
192.168.50.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
# route after
0.0.0.0         192.168.50.1    0.0.0.0         UG    0      0        0 eth0
0.0.0.0         10.8.0.1        128.0.0.0       UG    0      0        0 tun0
128.0.0.0       10.8.0.1        128.0.0.0       UG    0      0        0 tun0
192.168.50.0    0.0.0.0         255.255.255.0   U     0      0        0 eth0
10.8.0.0        0.0.0.0         255.255.255.0   U     0      0        0 tun0
97.64.22.60     192.168.50.1    255.255.255.255 UGH   0      0        0 eth0
# route cmd
/sbin/ip route add 97.64.22.60/32 via 192.168.50.1
/sbin/ip route add 0.0.0.0/1 via 10.8.0.1
/sbin/ip route add 128.0.0.0/1 via 10.8.0.1

# 启动openvpn client后server(ssh ss)不能用问题
https://serverfault.com/questions/659955/allowing-ssh-on-a-server-with-an-active-openvpn-client
## solution 1
ip rule add from $(ip route get 1 | grep -Po '(?<=src )(\S+)') table 128
ip route add table 128 to $(ip route get 1 | grep -Po '(?<=src )(\S+)')/32 dev $(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)')
ip route add table 128 default via $(ip -4 route ls | grep default | grep -Po '(?<=via )(\S+)')
## solution 2
// set "connection" mark of connection from eth0 when first packet of connection arrives
iptables -t mangle -A PREROUTING -i eth0 -m conntrack --ctstate NEW -j CONNMARK --set-mark 1234
// set "firewall" mark for response packets in connection with our connection mark
iptables -t mangle -A OUTPUT -m connmark --mark 1234 -j MARK --set-mark 4321
// our routing table with eth0 as gateway interface
ip route add default dev eth0 table 3412
// route packets with our firewall mark using our routing table
ip rule add fwmark 4321 table 3412
## check
ip rule list
ip route list table table_number
## knowledge
linux 系统中，可以自定义从 1－252个路由表，其中，linux系统维护了4个路由表：
0#表： 系统保留表
253#表： defulte table 没特别指定的默认路由都放在改表
254#表： main table 没指明路由表的所有路由放在该表
255#表： locale table 保存本地接口地址，广播地址、NAT地址 由系统维护，用户不得更改
路由表序号和表名的对应关系在 /etc/iproute2/rt_tables 文件中，可手动编辑。路由表添加完毕即时生效

