################################################################################
#
## libretro-bsnes
#
#################################################################################

PKG := LIBRETRO_BEETLE_PSX
LIBRETRO_BEETLE_PSX_VERSION = ca36c044e4deec4812ae20a35b8df129d61917ee
LIBRETRO_BEETLE_PSX_SITE = https://github.com/libretro/beetle-psx-libretro.git
LIBRETRO_BEETLE_PSX_SITE_METHOD = git
LIBRETRO_BEETLE_PSX_LICENSE = GPL-2.0
LIBRETRO_BEETLE_PSX_LICENSE_FILES = COPYING
#LIBRETRO_BEETLE_PSX_DEPENDENCIES = host-pkgconf host-gcc-final libgles
LIBRETRO_BEETLE_PSX_DEPENDENCIES = host-pkgconf libgles
#LIBRETRO_BEETLE_PSX_DEPENDENCIES = 
#LIBRETRO_BEETLE_PSX_MAKE_OPTS = HAVE_HW=1
#PKG_CONF_PATH=$(PKG_CONFIG_HOST_BINARY) 
#CFLAGS=$(shell pkg-config --cflags-only-I glesv2) 
#LIBRETRO_BEETLE_PSX_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS) -I$(HOST_DIR)/../staging/usr/include" \
#		CXXFLAGS="$(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include" \
#		LDFLAGS="$(TARGET_LDFLAGS) -L$(HOST_DIR)/../staging/usr/lib"
#		CXXFLAGS="-nostdinc++ -isystem $(STAGING_DIR)/../include -isystem $(STAGING_DIR)/usr/include" \

LIBRETRO_BEETLE_PSX_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include" \
		CXX="$(TARGET_CXX)" \
		CC="$(TARGET_CC)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include" \
		LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib"


#LIBRETRO_BEETLE_PSX_MAKE_OPTS = platform=unix SHELL="sh -x" V=1 HAVE_OPENGL=1
LIBRETRO_BEETLE_PSX_MAKE_OPTS_HW = platform=unix HAVE_OPENGL=1
LIBRETRO_BEETLE_PSX_MAKE_OPTS = platform=unix

define LIBRETRO_BEETLE_PSX_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(LIBRETRO_BEETLE_PSX_MAKE_ENV) $(MAKE) $(TARGET_MAKE_OPTS) $(LIBRETRO_BEETLE_PSX_MAKE_OPTS) -C $(LIBRETRO_BEETLE_PSX_SRCDIR)
	mv $(@D)/mednafen_psx_libretro.so $(@D)/mednafen_psx_libretro.so.bak 
	$(TARGET_MAKE_ENV) $(LIBRETRO_BEETLE_PSX_MAKE_ENV) $(MAKE) $(TARGET_MAKE_OPTS) -C $(LIBRETRO_BEETLE_PSX_SRCDIR) clean
	$(TARGET_MAKE_ENV) $(LIBRETRO_BEETLE_PSX_MAKE_ENV) $(MAKE) $(TARGET_MAKE_OPTS) $(LIBRETRO_BEETLE_PSX_MAKE_OPTS_HW) -C $(@D)
	mv $(@D)/mednafen_psx_libretro.so.bak $(@D)/mednafen_psx_libretro.so 
endef

define LIBRETRO_BEETLE_PSX_INSTALL_TARGET_CMDS
	#$(HOST_MAKE_ENV) $(LIBRETRO_BEETLE_PSX_MAKE_ENV) $(MAKE) $(LIBRETRO_BEETLE_PSX_INSTALL_OPTS) -C $(LIBRETRO_BEETLE_PSX_SRCDIR) install
	$(INSTALL) -D -m 0644 $(@D)/mednafen_psx_libretro.so -t $(TARGET_DIR)/usr/lib/libretro
	$(INSTALL) -D -m 0644 $(@D)/mednafen_psx_hw_libretro.so -t $(TARGET_DIR)/usr/lib/libretro
endef

$(eval $(generic-package))
