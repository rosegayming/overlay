# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%-bin}"
MY_DIR="${MY_PN^}"

inherit desktop linux-info optfeature pax-utils unpacker

DESCRIPTION="Extensible, fast and innovative web browser with Innatical UI."
HOMEPAGE="https://github.com/skyebrowser/skye#readme"
SRC_URI="https://github.com/skyebrowser/skye/releases/download/v${PV}/skye_${PV}_amd64.deb"
S="${WORKDIR}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
	x11-misc/xdg-utils
"

CONFIG_CHECK="~USER_NS"

src_install() {
	doicon usr/share/icons/hicolor/0x0/apps/${MY_PN}.png
	domenu usr/share/applications/${MY_PN}.desktop

	insinto /opt/${MY_DIR}
	doins -r opt/${MY_DIR}/.
	fperms +x /opt/${MY_DIR}/${MY_PN}
	dosym -r /opt/${MY_DIR}/${MY_DIR} /usr/bin/${MY_PN}
}

pkg_postinst() {
	optfeature "sound support" \
		media-sound/pulseaudio media-sound/apulse[sdk] media-video/pipewire
	optfeature "system tray support" dev-libs/libappindicator
}
