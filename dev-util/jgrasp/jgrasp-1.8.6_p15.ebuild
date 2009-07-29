# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
EAPI="1"

DESCRIPTION="A lightweight development environment"
HOMEPAGE="http://www.jgrasp.org/"
SRC_URI="ftp://ftp.eng.auburn.edu/pub/grasp/jgrasp/jgrasp186_15.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.5.0
	>=virtual/jre-1.5.0"
src_compile() {
	cd "${PN}/src"
	./configure
	./Make.sh
}
src_install() {	
	cd jgrasp
	dodir /usr/share/jgrasp/
	insinto /usr/share/jgrasp/
	doins jgrasp.jar
	dodir /usr/share/jgrasp/extensions
	doins -r extensions
	dodir /usr/share/jgrasp/data
	doins -r data/
	dodir /usr/share/jgrasp/bin
	dodir /usr/share/jgrasp/bin/linux
	insinto /usr/share/jgrasp/bin
	doins -r bin/linux
	dodir /usr/share/jgrasp/jbin
	insinto	/usr/share/jgrasp/jbin
	doins jbin/{linux_run,InputStream*,IsApplet.class,JGRASP*}
	dohtml help/*.htm
	fperms a+x /usr/share/jgrasp/bin/linux/jgrasp
	fperms a+x /usr/share/jgrasp/jbin/linux_run
	dosym /usr/share/jgrasp/bin/linux/jgrasp /usr/bin/jgrasp
	echo "JGRASP_HOME=\"/usr/share/jgrasp\"" > 20jgrasp
	doenvd 20jgrasp
	make_desktop_entry jgrasp "JGrasp" /usr/share/jgrasp/data/gric48.xpm
}
