################################################################################
#
## libretro-bsnes
#
#################################################################################

PKG := LIBRETRO_CORE_INFO
$(PKG)_VERSION = 1.8.1
$(PKG)_SOURCE = v$($(PKG)_VERSION).tar.gz
#$(PKG)_SITE = https://github.com/libretro/bsnes-libretro.git
#$(PKG)_SITE_METHOD = git
$(PKG)_SITE = https://github.com/libretro/libretro-core-info/archive
$(PKG)_LICENSE = MIT
$(PKG)_LICENSE_FILES = COPYING
#$(PKG)_DEPENDENCIES = host-pkgconf
#RETROARCH_DEPENDENCIES = host-pkgconf alsa-lib libxkbcommon sdl
#LIBRETRO_BSNES_CONF_OPTS = 
#RETROARCH_CONF_ENV += LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs alsa`"
#RETROARCH_CONF_ENV = PKG_CONF_PATH=$(PKG_CONFIG_HOST_BINARY) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig
#LIBRETRO_BSNES_CONF_ENV = PKG_CONF_PATH=$(PKG_CONFIG_HOST_BINARY)
#$(PKG)_PROFILE = balanced
#$(PKG)_MAKE_OPTS = prefix=/usr platform=linux
$(PKG)_INSTALL_OPTS = DESTDIR=$(TARGET_DIR)

#define $(PKG)_BUILD_CMDS
#	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_MAKE_OPTS) profile=balanced -C $($(PKG)_SRCDIR)
#	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_MAKE_OPTS) profile=accuracy -C $($(PKG)_SRCDIR)
#	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_MAKE_OPTS) profile=performance -C $($(PKG)_SRCDIR)
#	#$(MAKE) -C $(@D) all
#endef

#define RETROARCH_INSTALL_STAGING_CMDS
#	$(INSTALL) -D -m 0755 $(@D)/libfoo.a $(STAGING_DIR)/usr/lib/libfoo.a
#	$(INSTALL) -D -m 0644 $(@D)/foo.h $(STAGING_DIR)/usr/include/foo.h
#	$(INSTALL) -D -m 0755 $(@D)/libfoo.so* $(STAGING_DIR)/usr/lib
#endef

define $(PKG)_INSTALL_TARGET_CMDS
	$(HOST_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_INSTALL_OPTS) -C $($(PKG)_SRCDIR) install
endef

$(eval $(generic-package))
