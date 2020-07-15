################################################################################
#
## retroarch
#
#################################################################################

LIBRETRO_RETROARCH_VERSION = 1.8.4
LIBRETRO_RETROARCH_SOURCE = v$(LIBRETRO_RETROARCH_VERSION).tar.gz
LIBRETRO_RETROARCH_SITE = https://github.com/libretro/RetroArch/archive
LIBRETRO_RETROARCH_LICENSE = GPL-3
LIBRETRO_RETROARCH_LICENSE_FILES = COPYING
LIBRETRO_RETROARCH_DEPENDENCIES = host-pkgconf 
#LIBRETRO_RETROARCH_DEPENDENCIES = host-pkgconf alsa-lib libxkbcommon sdl
LIBRETRO_RETROARCH_CONF_OPTS = --disable-caca --disable-sixel --enable-sse --disable-miniupnpc --disable-builtinflac --disable-builtinmbedtls --disable-builtinminiupnpc --disable-builtinzlib --disable-jack --disable-oss --disable-sdl --enable-debug
#LIBRETRO_RETROARCH_CONF_ENV += LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs alsa`"
#LIBRETRO_RETROARCH_CONF_ENV = PKG_CONF_PATH=$(PKG_CONFIG_HOST_BINARY) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig
#LIBRETRO_RETROARCH_CONF_ENV = PKG_CONF_PATH=$(PKG_CONFIG_HOST_BINARY)
#LIBRETRO_RETROARCH_CONF_ENV = PKG_CONF_PATH=$(PKG_CONFIG_HOST_BINARY) PKG_CONFIG_FOR_BUILD=$(HOST_DIR)/bin/pkgconf
LIBRETRO_RETROARCH_CONF_ENV = PKG_CONF_PATH=$(PKG_CONFIG_HOST_BINARY) \
			      PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig/" \
			      CFLAGS="-I $(STAGING_DIR)/usr/include -DEGL_NO_X11 $(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
			      CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
			      LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_CFLAGS_SO) -lc" \

#LIBRETRO_RETROARCH_CONF_OPTS += $(patsubst %,--enable-%,$(patsubst ",,$(BR2_PACKAGE_RETROARCH_MENUS)))
#$(foreach OPT,BR2_PACKAGE_RETROARCH_XMB BR2_PACKAGE_RETROARCH_MATERIALUI, )

ifeq ($(BR2_PACKAGE_LIBRETRO_RETROARCH_XMB),y)
LIBRETRO_RETROARCH_CONF_OPTS += --enable-xmb
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-xmb
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_RETROARCH_RGUI),y)
LIBRETRO_RETROARCH_CONF_OPTS += --enable-rgui
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-rgui
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_RETROARCH_MATERIALUI),y)
LIBRETRO_RETROARCH_CONF_OPTS += --enable-materialui
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-materialui
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_RETROARCH_OZONE),y)
LIBRETRO_RETROARCH_CONF_OPTS += --enable-ozone
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-ozone
endif

#ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
#RETROARCH_CONF_OPTS += --enable-threads --enable-thread_storage
#else
#RETROARCH_CONF_OPTS += --disable-threads 
#endif

ifeq ($(BR2_PACKAGE_LIBRETRO_ALSA),y)
LIBRETRO_RETROARCH_DEPENDENCIES += alsa-lib
LIBRETRO_RETROARCH_CONF_OPTS += --enable-alsa
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_HAS_ZLIB),y)
LIBRETRO_RETROARCH_DEPENDENCIES += zlib
LIBRETRO_RETROARCH_CONF_OPTS += --enable-zlib
else
RETROARCH_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_GBM),y)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_GLES),y)
#LIBRETRO_RETROARCH_DEPENDENCIES += libgles libegl
#LIBRETRO_RETROARCH_CONF_OPTS += --enable-opengles --enable-egl
LIBRETRO_RETROARCH_DEPENDENCIES += libdrm libgles libegl
LIBRETRO_RETROARCH_CONF_OPTS += --enable-kms --enable-opengles --enable-egl
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-opengles
endif

#ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
ifeq ($(BR2_PACKAGE_LIBRETRO_GL),y)
LIBRETRO_RETROARCH_DEPENDENCIES += libgl libglu xorgproto xlib_libX11 xlib_libXext libglew
LIBRETRO_RETROARCH_CONF_OPTS += --enable-opengl --enable-x11 --enable-xvideo 
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-opengl --disable-x11 --disable-xvideo
endif

#ifeq ($(BR2_PACKAGE_RETROARCH_GLES),y)
#RETROARCH_DEPENDENCIES += libgl
#RETROARCH_CONF_OPTS += --enable-opengles --disable-x11 --disable-xvideo 
#else
#RETROARCH_CONF_OPTS += --disable-opengl --disable-x11 --disable-xvideo
#endif

#ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
#RETROARCH_DEPENDENCIES += libegl
#RETROARCH_CONF_OPTS += --enable-egl
#else
#RETROARCH_CONF_OPTS += --disable-egl
#endif

#ifeq ($(BR2_PACKAGE_LIBGLEW),y)
#RETROARCH_DEPENDENCIES += libglew 
#endif

#ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
#RETROARCH_DEPENDENCIES += libxkbcommon
#endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
LIBRETRO_RETROARCH_DEPENDENCIES += freetype
LIBRETRO_RETROARCH_CONF_OPTS += --enable-freetype
else
LIBRETRO_RETROARCH_CONF_OPTS += --disable-freetype
endif

	#$(TARGET_CONFIGURE_ARGS) \
	#CFLAGS="$(PKG_CONF_PATH) --"

define LIBRETRO_RETROARCH_CONFIGURE_CMDS
	(cd $(LIBRETRO_RETROARCH_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_ARGS) \
	$(TARGET_CONFIGURE_OPTS) \
	$(LIBRETRO_RETROARCH_CONF_ENV) \
	CONFIG_SITE=/dev/null \
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		$(QUIET) $(LIBRETRO_RETROARCH_CONF_OPTS) \
	)
endef

#define RETROARCH_BUILD_CMDS
#	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_MAKE_OPTS) -C $($(PKG)_SRCDIR)
#	#$(MAKE) -C $(@D) all
#endef

#define RETROARCH_INSTALL_STAGING_CMDS
#	$(INSTALL) -D -m 0755 $(@D)/libfoo.a $(STAGING_DIR)/usr/lib/libfoo.a
#	$(INSTALL) -D -m 0644 $(@D)/foo.h $(STAGING_DIR)/usr/include/foo.h
#	$(INSTALL) -D -m 0755 $(@D)/libfoo.so* $(STAGING_DIR)/usr/lib
#endef

#define RETROARCH_INSTALL_TARGET_CMDS
#	$(HOST_MAKE_ENV) $($(PKG)_MAKE_ENV) $(MAKE) $($(PKG)_INSTALL_OPTS) -C $($(PKG)_SRCDIR)
#endef

#ifeq ($(BR2_PACKAGE_FREETYPE),y)
#RETROARCH_DEPENDENCIES += freetype
#RETROARCH_CONF_OPTS += --enable-freetype
#else
#RETROARCH_CONF_OPTS += --disable-freetype
#endif
#
#ifeq ($(BR2_PACKAGE_XORG7)$(BR2_PACKAGE_HAS_LIBGL),yy)
#RETROARCH_DEPENDENCIES += libgl libglew libglu xlib_libX11 xlib_libXext
#RETROARCH_CONF_OPTS += --enable-gl --enable-x11
#else
#RETROARCH_CONF_OPTS += --disable-gl --disable-x11
#endif
#
#ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
#RETROARCH_DEPENDENCIES += libegl
#RETROARCH_CONF_OPTS += --enable-egl
#else
#RETROARCH_CONF_OPTS += --disable-egl
#endif

# Avoid freetype2 path poisoning by imake
#RETROARCH_CONF_ENV = ac_cv_path_IMAKE=""

#ifeq ($(BR2_PACKAGE_XLIB_LIBXFT),y)
#RETROARCH_DEPENDENCIES += xlib_libXft
#RETROARCH_CONF_OPTS += --enable-freetype \
#	--with-freetype-config=auto
#else
#RETROARCH_CONF_OPTS += --disable-freetype
#endif

#ifeq ($(BR2_PACKAGE_XLIB_LIBXINERAMA),y)
#RETROARCH_DEPENDENCIES += xlib_libXinerama
#RETROARCH_CONF_OPTS += --with-xinerama
#else
#RETROARCH_CONF_OPTS += --without-xinerama
#endif

$(eval $(autotools-package))
#$(eval $(generic-package))
