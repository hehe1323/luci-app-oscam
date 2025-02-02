include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-oscam
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=Your Name <your@email.com>

LUCI_TITLE:=LuCI Support for OSCam
LUCI_DEPENDS:=+luci-base +oscam
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/40_luci-oscam ) && rm -f /etc/uci-defaults/40_luci-oscam
	exit 0
}
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
