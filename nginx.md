### Nginx 配置补充说明
```nginx
# 前端静态资源服务（如 Vue/React 项目）
location ^~/residentDoctor/ {
    add_header Cache-Control no-cache;  # 强制浏览器不缓存
    add_header Cache-Control private;   # 仅允许私有缓存（如浏览器）
    expires -1s;                       # 设置过期时间为过去时间（立即失效）
    alias html/residentDoctor/;         # 静态资源实际路径
    try_files $uri $uri/ /residentDoctor/index.html; # 找不到文件时返回 index.html（用于前端路由）
}

# 反向代理到后端服务（如 Java/Python API）
location /ts-bs-his/ts-bs-emr {
    proxy_pass http://backend_server;   # 后端服务地址
    proxy_redirect off;                 # 关闭自动重定向
    
    proxy_set_header Cookie $http_cookie; # 传递原始 Cookie
    proxy_read_timeout 180s;           # 读取超时时间
    proxy_set_header Host $host;        # 传递域名信息
    proxy_set_header X-Real-IP $remote_addr; # 传递客户端真实 IP
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; # 客户端 IP 链
    proxy_cookie_path / "/; Path=/; HttpOnly; SameSite=Lax"; # Cookie 安全策略
    proxy_http_version 1.1;            # 启用 HTTP 1.1
    proxy_set_header Upgrade $http_upgrade; # WebSocket 升级头
    proxy_set_header Connection "upgrade"; # WebSocket 连接头
}
```

---

### 其他常见 Nginx 配置

#### 1. 负载均衡
```nginx
upstream backend {
    server 192.168.1.100:8080 weight=3; # 权重 3
    server 192.168.1.101:8080;
    server 192.168.1.102:8080 backup;  # 备用服务器
}

location /api/ {
    proxy_pass http://backend;
}
```

#### 2. HTTPS 配置
```nginx
server {
    listen 443 ssl;
    server_name example.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    # HSTS 安全增强
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
}
```

#### 3. 访问控制
```nginx
location /admin/ {
    allow 192.168.1.0/24;  # 允许内网访问
    deny all;              # 禁止其他所有 IP
    auth_basic "Restricted"; # 基础认证
    auth_basic_user_file /etc/nginx/.htpasswd;
}
```

#### 4. 重定向规则
```nginx
# HTTP 跳转到 HTTPS
server {
    listen 80;
    server_name example.com;
    return 301 https://$host$request_uri;
}

# 旧地址重定向
location /old-page {
    return 301 https://example.com/new-page;
}
```

#### 5. Gzip 压缩
```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml;
gzip_min_length 1024;
gzip_comp_level 6;
```

---

### 常用 Nginx 命令（Markdown 表格）

| 命令 | 描述 |
|------|------|
| `nginx -t` | 测试配置文件语法是否正确 |
| `nginx -s reload` | 重新加载配置（不中断服务） |
| `nginx -s stop` | 立即停止服务 |
| `nginx -s quit` | 优雅停止（处理完当前请求） |
| `nginx -V` | 查看编译参数和版本信息 |
| `tail -f /var/log/nginx/access.log` | 实时查看访问日志 |
| `systemctl status nginx` | 查看系统服务状态（Systemd） |
| `nginx -c /path/to/nginx.conf` | 指定配置文件启动 |

---

### 高级配置技巧
#### 1. **跨域配置**：
```nginx
# 核心 CORS 配置
add_header 'Access-Control-Allow-Origin' 'http://192.168.209.103:9099' always;
add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,Content-Type,Authorization' always;
add_header 'Access-Control-Allow-Credentials' 'true' always;
```

#### 2. **防盗链**：
```nginx
location ~* \.(jpg|png|gif)$ {
    valid_referers none blocked example.com;
    if ($invalid_referer) {
        return 403;
    }
}
```

#### 3. **限流**：
```nginx
limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;

location /api/ {
    limit_req zone=mylimit burst=20;
}
```

#### 4. **缓存策略**：
```nginx
location ~* \.(css|js|png)$ {
    expires 365d;
    add_header Cache-Control "public, no-transform";
}
```