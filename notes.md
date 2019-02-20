# 路由器ss离线安装包
https://github.com/hq450/fancyss_history_package/tree/master/fancyss_arm

# github安装最新ss版本
yum install -y python-pip git
pip install git+https://github.com/shadowsocks/shadowsocks.git@master
## 前台启动测试
ssserver -c /etc/shadowsocks.json
## 后端启动
ssserver -c /etc/shadowsocks.json -d start
## log
/var/log/shadowsocks.log

# 已经通过一键脚本自动化安装，再改用官方版本
修改 /etc/init.d/shadowsocks 脚本中的DEAMON

# bbr
## check
sysctl net.ipv4.tcp_available_congestion_control
### response
bbr cubic reno

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
