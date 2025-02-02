module("luci.controller.oscam", package.seeall)

function index()
    -- 注册菜单项
    entry({"admin", "services", "oscam"}, cbi("oscam"), _("OSCam"), 60).dependent = true
    -- 添加状态检查接口
    entry({"admin", "services", "oscam", "status"}, call("check_status")).leaf = true
end

-- 检查OSCam进程状态
function check_status()
    local sys = require "luci.sys"
    local http = require "luci.http"
    
    local pid = sys.exec("pgrep -f 'oscam -c /etc/oscam'")
    local is_running = pid ~= "" and pid ~= nil
    
    http.prepare_content("application/json")
    http.write_json({ running = is_running })
end
