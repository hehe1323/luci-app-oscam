include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-oscam
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=Your Name <your@email.com>
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-oscam
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=OSCam Configuration Interface
  DEPENDS:=+luci-base +oscam
  PKGARCH:=all
endef

define Package/luci-app-oscam/description
  LuCI interface for OSCam (Open Source Conditional Access Module) management.
endef

define Build/Prepare
    for d in luasrc files; do \
        if [ -d ./$$$$d ]; then \
            mkdir -p $(PKG_BUILD_DIR)/$$$$d; \
            cp -a ./$$$$d/* $(PKG_BUILD_DIR)/$$$$d/; \
        fi; \
    done
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-oscam/install
    # Install init script
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./files/etc/init.d/oscam $(1)/etc/init.d/oscam
    
    # Install LuCI components
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci
    cp -pR ./luasrc/* $(1)/usr/lib/lua/luci/
    
    # Install UCI config
    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_CONF) ./files/etc/config/oscam $(1)/etc/config/oscam
    
    # Install web files
    $(INSTALL_DIR) $(1)/www/luci-static/resources
    $(INSTALL_DATA) ./files/view/status.htm $(1)/usr/lib/lua/luci/view/oscam/
endef

define Package/luci-app-oscam/postinst
#!/bin/sh
    # Set permissions
    [ -x /usr/bin/oscam ] || chmod 755 /usr/bin/oscam
    [ -f /etc/oscam ] || mkdir -p /etc/oscam
    chmod 600 /etc/oscam/*
    
    # Add to Luci menu
    /etc/init.d/ucitrack reload >/dev/null 2>&1
    exit 0
endef

define Package/luci-app-oscam/install
    # 增加 Web 静态文件
    $(INSTALL_DIR) $(1)/www/luci-static/resources
    $(INSTALL_DATA) ./files/view/logs.htm $(1)/usr/lib/lua/luci/view/oscam/
endef

$(eval $(call BuildPackage,luci-app-oscam))
