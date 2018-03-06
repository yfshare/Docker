#!/bin/bash
#elasticsearch文件授权
chown elasticsearch:elasticsearch /data -R
chown elasticsearch:elasticsearch /etc/elasticsearch -R

#启动elasticsearch服务
sh /etc/init.d/elasticsearch.sh start

#主进程
echo '我是主进程' > /main.txt
tail -f /main.txt
