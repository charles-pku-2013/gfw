# 路由器ss离线安装包
https://github.com/hq450/fancyss_history_package/tree/master/fancyss_arm

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

# bbr
## check
sysctl net.ipv4.tcp_available_congestion_control
### response
bbr cubic reno


# iptables 流量转发
https://www.debuntu.org/how-to-redirecting-network-traffic-to-a-new-ip-using-iptables/
## 一键安装
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
