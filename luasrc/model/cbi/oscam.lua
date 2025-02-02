m = Map("oscam", "OSCam Configuration", "Configure OSCam service settings")

s = m:section(TypedSection, "main", "Basic Settings")
s.anonymous = true

s:option(Flag, "enabled", "Enable OSCam", "Start OSCam service automatically")
s:option(Flag, "pcsc", "Enable PC/SC", "Support PC/SC smart card readers")

btn = s:option(Button, "_control", "Service Control")
btn.template = "oscam/control"

btn = s:option(DummyValue, "_status", "Service Status")
btn.template = "oscam/status"

return m
