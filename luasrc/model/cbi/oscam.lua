local m, s, o

-- 绑定到UCI配置文件/etc/config/oscam
m = Map("oscam", translate("OSCam Configuration"), translate("Configure OSCam settings."))

-- 通用设置部分
s = m:section(TypedSection, "main", translate("General Settings"))
s.anonymous = true

-- Web管理端口
o = s:option(Value, "httpport", translate("Web Port"))
o.datatype = "port"
o.default = "8888"

-- 用户名
o = s:option(Value, "httpuser", translate("Username"))
o.default = "oscam"

-- 密码
o = s:option(Value, "httppwd", translate("Password"))
o.password = true

-- 动态生成打开后台的链接
local ip = luci.http.getenv("SERVER_ADDR") or "192.168.1.1"
local port = m:get(s.section, "httpport") or "8888"
o = s:option(DummyValue, "_webui", translate("Open Web Interface"))
o.rawhtml = true
o.template = "oscam/webui_button"
o.value = string.format("http://%s:%s", ip, port)

-- 进程守护开关
s = m:section(TypedSection, "service", translate("Service Control"))
s.anonymous = true
o = s:option(Button, "_control", translate("Service Status"))
o.template = "oscam/service_control"

return m
