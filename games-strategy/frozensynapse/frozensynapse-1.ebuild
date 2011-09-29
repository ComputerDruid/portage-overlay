# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils games

DESCRIPTION="A Simultaneous Turn-Based Strategy Game / Turn-Based Tactical Game"
HOMEPAGE="http://www.frozensynapse.com/"
SRC_URI="frozensynapse-${PV}-linux-bin"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="
	x86? (
		media-libs/libsdl[audio,video]
		media-libs/alsa-lib
	)
	amd64? (
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-sdl
	)"

RESTRICT="fetch"

S="${WORKDIR}"/data
dir="${GAMES_PREFIX_OPT}/${PN}"

pkg_nofetch() {
	ewarn
	ewarn "Place ${A} to ${DISTDIR}"
	ewarn
}

src_unpack() {
	unzip -q "${DISTDIR}"/${A}
	[ $? -gt 1 ] && die "unpacking failed"
}

src_install() {
	insinto "${dir}"
	doins -r cacert.pem common fontchars.txt fontlist.txt frozensynapse.png main.cs psychoff TGB tools \
		|| die "doins failed"

	local exe=FrozenSynapse
	exeinto "${dir}"
	doexe ${exe} || die "doexe failed"

	games_make_wrapper ${PN} ./${exe} "${dir}" "${dir}"
	doicon ${PN}.png
	make_desktop_entry ${PN} "FrozenSynapse" ${PN}

	prepgamesdirs
}
