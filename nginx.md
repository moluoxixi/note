```shell
location ^~/residentDoctor/ {
		add_header Cache-Control no-cache;
		add_header Cache-Control private;
		expires -1s;
		alias html/residentDoctor/; #打包以后的项目路径
		try_files $uri $uri/ /residentDoctor/index.html; #解决404问题
}


#his的前端服务-病历
location  /ts-bs-his/ts-bs-emr {
	#代理地址
	proxy_pass   地址;
	# 代理重定向
	proxy_redirect  地址;
	proxy_set_header Cookie $http_cookie;
	proxy_read_timeout	180s;
	proxy_connect_timeout	120s;
	proxy_set_header   Host             $http_host;
	proxy_set_header   X-Real-IP        $remote_addr;
	proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
	#proxy_cookie_path / "/; HttpOnly; secure; SameSite=Lax";

	proxy_cookie_path / "/; Path=/; HttpOnly; SameSite=Lax";
	# websoket相关配置：必须
	proxy_http_version 1.1;
	proxy_set_header Upgrade $http_upgrade;
	proxy_set_header  Connection "upgrade";
}
```