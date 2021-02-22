# for router
https://github.com/hq450/fancyss
## koolshare
email: qmail
pass: G06
## 固件下载
https://firmware.koolshare.cn/
## 新版软件中心关键词屏蔽解决
sed -i 's/\tdetect_package/\t# detect_package/g' /koolshare/scripts/ks_tar_install.sh
## config & command 配置文件 启动命令
/jffs/.koolshare/bin/v2ctl config /koolshare/ss/v2ray.json

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

