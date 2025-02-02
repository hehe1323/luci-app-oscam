module("luci.controller.oscam", package.seeall)

function index()
    entry({"admin", "services", "oscam"}, firstchild(), _("OSCam"), 60).dependent = false
    entry({"admin", "services", "oscam", "status"}, call("action_status"), _("Status"), 10)
    entry({"admin", "services", "oscam", "config"}, cbi("oscam"), _("Configuration"), 20)
end

function action_status()
    local sys = require "luci.sys"
    local status = {
        running = (sys.call("pgrep oscam >/dev/null") == 0),
        pcsc_enabled = (luci.model.uci.cursor():get("oscam", "main", "pcsc") or "0") == "1"
    }
    luci.http.prepare_content("application/json")
    luci.http.write_json(status)
end
