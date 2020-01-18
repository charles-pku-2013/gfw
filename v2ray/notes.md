# 一键安装
https://github.com/233boy/v2ray/wiki/V2Ray%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85%E8%84%9A%E6%9C%AC
<!-- bash <(curl -s -L https://git.io/v2ray.sh) -->
## ws + tls
### namesilo bfyviolin g06
### cloudflare gmail C01PKU
### v2-ui
https://blog.sprov.xyz/2019/08/03/v2-ui/
### nginx 网站伪装
https://www.v2rayssr.com/easyv2ray.html
<!-- bash <(curl -L -s https://raw.githubusercontent.com/wulabing/V2Ray_ws-tls_bash_onekey/master/install.sh) | tee v2ray_ins.log -->

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

