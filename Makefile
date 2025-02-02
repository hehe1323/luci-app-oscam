include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-oscam
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=Your Name <your@email.com>

LUCI_TITLE:=LuCI Support for OSCam
LUCI_DEPENDS:=+luci-base +oscam
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# 调用OpenWrt的Luci构建系统
define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
    ( . /etc/uci-defaults/40_luci-oscam ) && rm -f /etc/uci-defaults/40_luci-oscam
    exit 0
}
endef

# 安装初始化脚本
define Package/$(PKG_NAME)/install
    $(INSTALL_DIR) $(1)/etc/uci-defaults
    echo "#!/bin/sh" > $(1)/etc/uci-defaults/40_luci-oscam
    echo "[ -e '/etc/config/oscam' ] || touch /etc/config/oscam" >> $(1)/etc/uci-defaults/40_luci-oscam
    echo "exit 0" >> $(1)/etc/uci-defaults/40_luci-oscam
    chmod 755 $(1)/etc/uci-defaults/40_luci-oscam
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
