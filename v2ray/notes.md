# adjust time & timezone
date -R
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 配置生成器
https://intmainreturn0.com/v2ray-config-gen/#

# 二维码生成函数
get_v2ray_config_qr_link

# op
## start
systemctl restart v2ray
## check
service v2ray status

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

