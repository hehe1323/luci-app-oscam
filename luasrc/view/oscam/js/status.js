XHR.poll(5, '<%=luci.dispatcher.build_url("admin", "services", "oscam", "status")%>', null,
    function(x, info) {
        document.getElementById('status').innerHTML = info.running ? 
            '<span style="color: green"><%:Running%></span>' : 
            '<span style="color: red"><%:Stopped%></span>';
        document.getElementById('pcsc').innerHTML = info.pcsc_enabled ?
            '<span style="color: green"><%:Enabled%></span>' :
            '<span style="color: red"><%:Disabled%></span>';
    }
);
