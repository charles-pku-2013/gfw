# 路由器ss离线安装包
https://github.com/hq450/fancyss_history_package/tree/master/fancyss_arm384

# github安装最新ss版本
yum install -y python-pip git libsodium
apt-get update -y
apt-get install -y python-pip git libsodium-dev
pip install git+https://github.com/shadowsocks/shadowsocks.git@master
## 前台启动测试
ssserver -c /etc/shadowsocks.json
## 后端启动
ssserver -c /etc/shadowsocks.json -d start
ssserver -c /etc/shadowsocks.json -d restart
ssserver -c /etc/shadowsocks.json -d stop
## log
tail -n 500 -f /var/log/shadowsocks.log

# 已经通过一键脚本自动化安装，再改用官方版本
修改 /etc/init.d/shadowsocks 脚本中的DEAMON

# ss一键安装
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ss-go.sh && chmod +x ss-go.sh && bash ss-go.sh
## 启动命令 new chacha20
./shadowsocks-go -s :443 -cipher aead_chacha20_poly1305 -password $passwd

# SSR 一键安装 逗比
## 先安装libsodium
yum install -y python-pip git libsodium
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssr.sh && chmod +x ssr.sh && bash ssr.sh
## 配置文件 config
/etc/shadowsocksr/user-config.json

# bbr
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
## check
sysctl net.ipv4.tcp_available_congestion_control
response
bbr cubic reno
## enable in debian 9
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

# iptables 流量转发
https://www.debuntu.org/how-to-redirecting-network-traffic-to-a-new-ip-using-iptables/
## 一键安装 改用natconfig.sh
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/iptables-pf.sh && chmod +x iptables-pf.sh && bash iptables-pf.sh
## enable forwarding
echo "1" > /proc/sys/net/ipv4/ip_forward
or
sysctl net.ipv4.ip_forward=1
or
/etc/sysctl.conf  net.ipv4.ip_forward
sysctl -p
## add rules
iptables -t nat -A PREROUTING -p tcp (-m tcp) -j DNAT --to-destination 2.2.2.2:1111
iptables -t nat -A PREROUTING -s 192.168.1.0/24 -p tcp -j DNAT --to-destination 2.2.2.2:1111
iptables -t nat -A PREROUTING  -p tcp -i eth0 -d 1.2.3.5 -j DNAT --to-destination 10.11.1.2
iptables -t nat -A PREROUTING -i eth0 -p udp --dport 5555 -j DNAT --to-destination 192.168.180.125:5555
### 亲测可用 这样连ssh端口也转发 导致无法登陆
iptables -t nat -A PREROUTING -i eth0 -j DNAT --to-destination 34.92.252.119

iptables -t nat -A PREROUTING -s [source network / mask] -p tcp --dport 80 -j DNAT --to-destination [your webserver]
## finally
iptables -t nat -A POSTROUTING -j MASQUERADE
service iptables save
service iptables restart
## 指定端口号区间 10000:20000
## list rules
iptables -S (TCP)

# iptables for v2ray openwrt
https://github.com/felix-fly/v2ray-openwrt
## Only TCP
iptables -t nat -N V2RAY
iptables -t nat -A V2RAY -d 0.0.0.0 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.0 -j RETURN
iptables -t nat -A V2RAY -d 192.168.1.0/24 -j RETURN
### From lans redirect to Dokodemo-door's local port
iptables -t nat -A V2RAY -s 192.168.1.0/24 -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A PREROUTING -p tcp -j V2RAY
## With UDP support
ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100
iptables -t mangle -N V2RAY
iptables -t mangle -A V2RAY -d 0.0.0.0 -j RETURN
iptables -t mangle -A V2RAY -d 127.0.0.0 -j RETURN
iptables -t mangle -A V2RAY -d 192.168.1.0/24 -j RETURN
### From lans redirect to Dokodemo-door's local port
iptables -t mangle -A V2RAY -p tcp -s 192.168.1.0/24 -j TPROXY --on-port 12345 --tproxy-mark 1
iptables -t mangle -A V2RAY -p udp -s 192.168.1.0/24 -j TPROXY --on-port 12345 --tproxy-mark 1
iptables -t mangle -A PREROUTING -j V2RAY

# kcptun 一键安装
https://ssr.tools/588
## 常用命令
启动：
supervisorctl start kcptun
停止：
supervisorctl stop kcptun
重启：
supervisorctl restart kcptun
状态：
supervisorctl status kcptun
卸载：
./kcptun.sh uninstall

# kcptun config
{
  "localaddr": ":14747",
  "remoteaddr": "35.220.233.23:29900",
  "key": "passwd",
  "crypt": "none",
  "mode": "fast",
  "mtu": 1350,
  "sndwnd": 512,
  "rcvwnd": 512,
  "datashard": 10,
  "parityshard": 3,
  "dscp": 0,
  "nocomp": true,
  "quiet": false
}

# domain 腾讯云域名
www.charlesio.xyz

# for router
https://github.com/hq450/fancyss
## koolshare
email: qmail
pass: G06

# update v2ray for router v2ray-arm
https://github.com/v2ray/v2ray-core/releases
download v2ray-linux-arm32-v5.zip
replace v2ray v2ctl

# 路由器工具安装 opkg
https://www.chiphell.com/thread-1347856-1-1.html
mkdir -p /jffs/opt
ln -nsf /jffs/opt /tmp/opt
wget http://qnapware.zyxmon.org/binaries-armv7/installer/entware_install_arm.sh
sh ./entware_install_arm.sh
vi /jffs/scripts/post-mount Add
ln -nsf /jffs/opt /tmp/opt
## check cpu model armv7l 32bit
uname -m


# 付费 buy paid
## stc
https://stc-beta4.com
qmail
g06
## 次元链接
https://portal.cylink0122.icu/



