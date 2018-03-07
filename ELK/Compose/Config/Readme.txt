此目录存储为基于docker容器部署的ELK配置文件  

ELK版本为6.2.2，filebeat版本为6.2.2  

docker-compose -f elk-compose.yml up -d
docker-compose -f filebeat-compose.yml up -d
部署后，在kibana添加索引后即可读取nginx日志  

[root@localhost elk]# tree .
.
├── elasticsearch
│   ├── elasticsearch.yml
│   └── jvm.options
├── elasticsearch-compose.yml
├── elk-compose.yml
├── filebeat
│   └── filebeat.yml
├── filebeat-compose.yml
├── kibana
│   └── kibana.yml
├── kibana-compose.yml
├── logstash
│   ├── conf.d
│   │   └── logstash.conf
│   ├── jvm.options
│   └── logstash.yml
└── logstash-compose.yml

5 directories, 12 files
[root@localhost elk]#
