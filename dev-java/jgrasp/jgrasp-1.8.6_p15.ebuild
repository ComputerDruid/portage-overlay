# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="A Java IDE"
HOMEPAGE="http://www.jgrasp.org/"
SRC_URI="ftp://ftp.eng.auburn.edu/pub/grasp/jgrasp/jgrasp186_15.zip"

LICENSE=""
SLOT="1.8.6"
KEYWORDS="amd64"
IUSE=""

DEPEND="app-arch/unzip
	>=virtual/jdk-1.5.0
	>=virtual/jre-1.5.0"
RDEPEND=">=virtual/jdk-1.5.0
	>=virtual/jre-1.5.0"
src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
	fi
}
src_compile() {
	cd "${S}/src"
	./configure --mandir /usr/local/share/man --bindir /usr/local/bin/
	./Make.sh
}
src_install() {
	cd ../
	#rm -rf bin/osx104 bin/solaris bin/jgrasp95.exe bin/jgrasp.exe
	#bin/winconfig.exe src/
	dodir /usr/share
	cp -R "${S}" "${D}" || die "Install failed!"
	ln -s "${D}"/jgrasp/bin/linux/jgrasp /usr/bin/jgrasp
}
pkg_prerm() {
	rm /usr/bin/jgrasp
	rm -rf /usr/share/jgrasp
}
