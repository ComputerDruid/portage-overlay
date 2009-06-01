# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="A lightweight development environment"
HOMEPAGE="http://www.jgrasp.org/"
SRC_URI="ftp://ftp.eng.auburn.edu/pub/grasp/jgrasp/jgrasp187b2.zip"

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
	insinto /usr/share/
	doins -r *
	fperms a+x /usr/share/jgrasp/bin/linux/jgrasp
	fperms a+x /usr/share/jgrasp/jbin/linux_run
	dosym /usr/share/jgrasp/bin/linux/jgrasp /usr/bin/jgrasp
	echo "JGRASP_HOME=\"/usr/share/jgrasp\"" > 20jgrasp
	doenvd 20jgrasp
}
