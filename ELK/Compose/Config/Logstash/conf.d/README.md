此目录存储为基于docker容器部署的logstash配置文件

logstash版本为6.2.2

nginx log_format  
```bash
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$request_time" "$upstream_response_time" "$http_user_agent" "$http_x_forwarded_for"';
```

grok
```bash
%{IPV4:remote_addr} [\-] %{USERNAME:remote_user} \[%{DATA:time_local}\] \"(?<request>[^\"]*)\" (?<status>\d+) (?<body_bytes_sent>\d+) \"(?<http_referer>[^\"]*)\" \"%{BASE10NUM:request_time}\" \"[\-]\" \"(?<http_user_agent>[^\"]*)\" \"%{IPV4:http_x_forwarded_for}\"
```
