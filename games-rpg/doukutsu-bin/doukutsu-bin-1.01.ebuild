# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Side-scrolling platformer written by StudioPixel (English
translation)"
HOMEPAGE="http://www.cavestory.org"
SRC_URI="http://www.scibotic.com/uploads/2008/04/linuxdoukutsu-${PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="strip"

RDEPEND="media-libs/libsdl"

S=${WORKDIR}/linuxDoukutsu-${PV}
src_install() {
	dogamesbin doukutsu || die dogamesbin failed
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data Config.dat DoConfig.exe
	exeinto "${GAMES_DATADIR}"/${PN}
	doexe doukutsu.bin
	dosym "${GAMES_STATEDIR}"/${PN}/Profile.dat "${GAMES_DATADIR}"/${PN}/Profile.dat
	games_make_wrapper doukutsu ./doukutsu.bin "${GAMES_DATADIR}"/${PN} "${GAMES_DATADIR}"/${PN}
	dodoc doc/*
	touch Profile.dat
	insopts -m 660
	insinto "${GAMES_STATEDIR}"/${PN}
	doins Profile.dat
	prepgamesdirs
}
pkg_postinst() {
	elog "This port does not provide a configuration tool for Config.dat. The
	original DoConfig.exe is provided (if you can use wine), or help for
	configuring it manually is provided in:
	/usr/share/doc/${P}/configfileformat.txt"
	elog "If you need to back up your save file for any reason, it is located at
	/var/games/doukutsu-bin/Profile.dat"
}
