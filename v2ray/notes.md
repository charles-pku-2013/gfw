# 一键安装
https://github.com/233boy/v2ray/wiki/V2Ray%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85%E8%84%9A%E6%9C%AC
bash <(curl -s -L https://git.io/v2ray.sh)
## 官方脚本
https://v2raycn.com/46.html
<!-- bash <(curl -L -s https://install.direct/go.sh) -->

# 搬瓦工 bandwagon
sspku.xyz
gmail
g0
port: 27315
X6qYbJNDcaWa
Your backup key: LLZWCQRX2N2YZE7N
## ws + tls
### namesilo bfyviolin g06
My Account -> Domain Manager -> Manage DNS for this domain (蓝色圆形)
添加两条A记录，第一条填空，第二条www，删除其他的
    A   45.62.121.78    NA  7207*   3rd-party
www A   45.62.121.78    NA  7207*   3rd-party
设置DNS服务器(最后一个图标,3个圆饼) jim.ns.cloudflare.com, princess.ns.cloudflare.com
### cloudflare https://www.cloudflare.com gmail C01PKU
#### remove domian site
https://support.cloudflare.com/hc/zh-cn/articles/360033554252-%E4%BB%8E-Cloudflare-%E4%B8%AD%E5%88%A0%E9%99%A4%E5%9F%9F%E5%90%8D
Advanced Option -> Remove ...
### v2-ui
https://blog.sprov.xyz/2019/08/03/v2-ui/
### nginx 网站伪装 一键安装
https://www.v2rayssr.com/easyv2ray.html
<!-- bash <(curl -L -s https://raw.githubusercontent.com/wulabing/V2Ray_ws-tls_bash_onekey/master/install.sh) | tee v2ray_ins.log -->
### 宝塔 + nginx + v2ray
https://www.v2rayssr.com/v2raybaota.html
https://www.youtube.com/watch?v=StfMfa1uk7U&list=PLizxI6bXDPzMllC4U17KFq5kejc4Z9iJY&index=3&t=1473s
1. 安装之前的一键脚本
2. systemctl disable nginx  禁用之前安装的nginx
3. 宝塔开启nginx，创建站点（站点路径可服用之前的），并开启SSL
4. 添加站点转发配置(注意！配置实在网站配置里，不是nginx配置)
location /7be84b44 {
    proxy_redirect off;
    proxy_pass http://127.0.0.1:35122;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $http_host;
}

# Get linux distribution debian centos
apt-get install -y lsb-release
lsb_release -a

# AWS amazon cloud
18.183.87.78
www.sunchao.monster
s15600687960@163.com
G06
user: charlespku2013
ssh -i aws.pem admin@sunchao.monster
EC2

# adjust time & timezone
date -R
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 配置生成器
https://intmainreturn0.com/v2ray-config-gen/#
# 客户端配置
v2ray_client_config="/etc/v2ray/233blog_v2ray_config.json"

# 二维码生成函数 qr code
get_v2ray_config_qr_link
## centos
yum install -y qrencode git

# op
## start
systemctl restart v2ray
## check
service v2ray status

# process info / start
/usr/bin/v2ray/v2ray -config /etc/v2ray/config.json

# uninstall
停用并卸载服务（systemd）：
systemctl stop v2ray
systemctl disable v2ray

停用并卸载服务（sysv）：
service v2ray stop
update-rc.d -f v2ray remove

然后删除以下文件：
/etc/v2ray/* (配置文件)
/usr/bin/v2ray/* (程序)
/var/log/v2ray/* (日志)
/lib/systemd/system/v2ray.service (systemd 启动项)
/etc/init.d/v2ray (sysv 启动项)


# docker
https://github.com/v2fly/docker
docker build -t v2ray:latest .
## tutorial
https://toutyrater.github.io/app/docker-deploy-v2ray.html

# docker with systemd service
docker pull centos/systemd
docker run -d --restart always -v `pwd`:/share -p 8500:8500 --name v2ray --privileged  centos/systemd:latest /usr/sbin/init
docker run -d --restart always -v `pwd`:/share -p 8500:8500 --name v2ray --privileged  centos:v2ray /usr/sbin/init
yum update -y
yum install -y wget curl net-tools openssl initscripts which vim


# service v2ray /etc/systemd/system/v2ray.service
[Unit]
Description=V2Ray Service
After=network.target
Wants=network.target

[Service]
Type=simple
PIDFile=/run/v2ray.pid
ExecStart=/usr/bin/v2ray/v2ray -config /etc/v2ray/config.json
Restart=always
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target

# geoip geosite
wget -q https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geoip.dat -O /usr/bin/geoip.dat >/dev/null >/dev/null
wget -q https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geosite.dat -O /usr/bin/geosite.dat >/dev/null >/dev/null




