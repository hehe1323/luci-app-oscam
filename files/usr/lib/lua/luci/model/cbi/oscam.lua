m = Map("oscam", "OSCam Configuration")

s = m:section(TypedSection, "oscam", "Settings")
s.anonymous = true

s:option(Flag, "enabled", "Enable OSCam").default = 0

config_dir = s:option(Value, "config_dir", "Configuration Directory")
config_dir.default = "/etc/oscam"
config_dir.rmempty = false

btn = s:option(Button, "_btn", "Control")
btn.inputtitle = "Apply Configuration"
btn.inputstyle = "apply"
function btn.write()
    os.execute("/etc/init.d/oscam restart")
end

return m
