#!/bin/bash
# resolc.conf の存在を確認しなければ作成する
if [ ! -f "/etc/resolv.conf" ] ; then
    touch /etc/resolv.conf
    echo "nameserver 8.8.8.8" >> /etc/resolv.conf
fi
 
