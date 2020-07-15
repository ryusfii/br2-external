################################################################################
#
## libretro-bsnes
#
#################################################################################

PKG := LIBRETRO_BSNES
$(PKG)_VERSION = feb8c10c672094e689ed057a278c2b354e113f32
$(PKG)_SITE = https://github.com/libretro/bsnes-libretro.git
$(PKG)_SITE_METHOD = git
$(PKG)_LICENSE = GPL-3.0
$(PKG)_LICENSE_FILES = COPYING
#$(PKG)_DEPENDENCIES = host-pkgconf
$(PKG)_MAKE_OPTS = prefix=/usr platform=linux
#$(PKG)_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include"

define $(PKG)_BUILD_CMDS
	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_MAKE_OPTS) profile=balanced -C $($(PKG)_SRCDIR)
	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_MAKE_OPTS) profile=accuracy -C $($(PKG)_SRCDIR)
	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_MAKE_OPTS) profile=performance -C $($(PKG)_SRCDIR)
	#$(MAKE) -C $(@D) all
endef

define $(PKG)_INSTALL_TARGET_CMDS
	#$(HOST_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_INSTALL_OPTS) -C $($(PKG)_SRCDIR) install
	$(INSTALL) -D -m 0644 $(@D)/out/bsnes2014_accuracy_libretro.so -t $(TARGET_DIR)/usr/lib/libretro
	$(INSTALL) -D -m 0644 $(@D)/out/bsnes2014_balanced_libretro.so -t $(TARGET_DIR)/usr/lib/libretro
	$(INSTALL) -D -m 0644 $(@D)/out/bsnes2014_performance_libretro.so -t $(TARGET_DIR)/usr/lib/libretro
endef

$(eval $(generic-package))
