# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/sauerbraten/sauerbraten-2008.06.17.ebuild,v 1.3 2009/03/09 19:27:37 mr_bones_ Exp $

EAPI=2

inherit eutils games

DESCRIPTION="free multiplayer/singleplayer first person shooter (major redesign of the Cube FPS)"
HOMEPAGE="http://sauerbraten.org/"
SRC_URI="mirror://sourceforge/sauerbraten/sauerbraten_${PV//./_}_trooper_edition_linux.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#RESTRICT="strip"

RDEPEND="sys-libs/glibc
		media-libs/libsdl[opengl]
		media-libs/sdl-mixer[mp3,vorbis]
		media-libs/sdl-image[jpeg,png]"
DEPEND="$RDEPEND"

S=${WORKDIR}/${PN}

src_prepare() {
	ecvs_clean
	rm -r bin_unix/*
}

src_compile() {
	cd src
	emake
	emake install
}

src_install() {
	exeinto "$(games_get_libdir)"/${PN}
	doexe bin_unix/native_{client,server} || die

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data packages || die

	local x
	for x in client server ; do
		newgamesbin "${S}"/sauerbraten_unix ${PN}_${x}-bin || die
		sed -i \
			-e "s:SAUER_BIN=\${SAUER_DATA}/bin_unix:SAUER_BIN=$(games_get_libdir)/${PN}:g" \
			-e "s:bin_unix/::g" \
			-e "s:client:${x}:g" \
			-e "s:SAUER_DATA=.:SAUER_DATA=${GAMES_DATADIR}/${PN}:g" \
			"${D}/${GAMES_BINDIR}"/${PN}_${x}-bin \
			|| die "unable to sed ${D}/${GAMES_BINDIR}/${PN}_${x}-bin"
	done

	dohtml -r README.html docs

	make_desktop_entry ${PN}_client-bin ${PN}

	prepgamesdirs
}
