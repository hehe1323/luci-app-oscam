include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Web Interface for OSCam
LUCI_DEPENDS:=+luci-compat +oscam
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-oscam
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# 定义安装后操作
define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
    ( . /etc/uci-defaults/99_luci-oscam ) && rm -f /etc/uci-defaults/99_luci-oscam
    exit 0
}
endef

# 调用 LuCI 构建宏
$(eval $(call BuildPackage,$(PKG_NAME)))
