module("luci.controller.oscam", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/oscam") then
        return
    end

    entry({"admin", "services", "oscam"}, cbi("oscam"), _("OSCam"), 60).dependent = true
    entry({"admin", "services", "oscam", "action"}, call("action")).leaf = true
end


function stream_log()
-- 在 oscam.lua 控制器中添加
    entry({"admin", "services", "oscam", "log"}, call("stream_log"))    
    local t = require "luci.template"
    t.render("oscam/logs")
end

function action()
    local cmd = luci.http.formvalue("cmd")
    if cmd == "start" then
        luci.sys.init.start("oscam")
    elseif cmd == "stop" then
        luci.sys.init.stop("oscam")
    elseif cmd == "restart" then
        luci.sys.init.restart("oscam")
    end
    luci.http.prepare_content("application/json")
    luci.http.write_json({ status = "OK" })
end
