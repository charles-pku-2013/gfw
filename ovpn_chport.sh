#!/bin/bash

SERVER_CONF=/etc/openvpn/server.conf
ADD_RULE=/etc/iptables/add-openvpn-rules.sh
RM_RULE=/etc/iptables/rm-openvpn-rules.sh
# SERVER_CONF=server.conf
# ADD_RULE=add-openvpn-rules.sh
# RM_RULE=rm-openvpn-rules.sh

old_port=`grep 'port' $SERVER_CONF | awk '{print $NF}'`
if [ -z "$old_port" ]; then
    echo "Cannot detect old port!"
    exit 0
fi

if [ $# -lt 1 ]; then
    echo "Current port is $old_port"
    exit 0
fi

if [[ $1 -lt 1025 || $1 -gt 65535 ]]; then
    echo "$1 is not a valid port number!"
    exit 0
fi
new_port=$1

echo "Changing ovpn port from $old_port to $new_port"
# set server.conf
sed -i -e "s/port\ *$old_port/port $new_port/g" $SERVER_CONF
# rules
sed -i -e "s/--dport\ *$old_port/--dport $new_port/g" $ADD_RULE
sed -i -e "s/--dport\ *$old_port/--dport $new_port/g" $RM_RULE

reboot




