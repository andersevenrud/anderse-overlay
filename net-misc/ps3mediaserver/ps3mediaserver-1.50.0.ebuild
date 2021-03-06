# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Author: Anders Evenrud <andersevenrud@gmail.com>

EAPI="2"

MY_PV="1.50.0"
MY_PV2="1.50.0"

DESCRIPTION="DLNA compliant UPNP server for streaming media to Playstation 3"
HOMEPAGE="http://code.google.com/p/ps3mediaserver"
SRC_URI="http://ps3mediaserver.googlecode.com/files/pms-generic-linux-unix-${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+transcode tsmuxer"

DEPEND=""
RDEPEND=">=virtual/jre-1.6.0
	tsmuxer? ( media-video/tsmuxer )
	transcode? ( media-video/mplayer[encode] )"

S=${WORKDIR}/pms-linux-${MY_PV2}

src_prepare() {
	rm linux/tsMuxeR* || die
	cat <<-EOF > ${PN}
	#!/bin/sh
	echo "Setting up ~/.${PN} based on /usr/share/${PN}/"
	if [ ! -e ~/.${PN} ] ; then
		mkdir -p ~/.${PN}
		cp -pPR /usr/share/${PN}/* ~/.${PN}/
	fi
	cd ~/.${PN}
	PMS_HOME=\$PWD
	EOF
	cat PMS.sh >> ${PN}
}

src_install() {
	dobin ${PN} || die
	insinto /usr/share/${PN}
	doins -r pms.jar *.conf linux plugins renderers || die
	use tsmuxer && { dosym /opt/bin/tsMuxeR /usr/share/${PN}/linux/ || die ; }
	dodoc CHANGELOG README
}

pkg_postinst() {
	ewarn "Don't forget to disable transcoding engines for software"
	ewarn "that you don't have installed (such as having the VLC"
	ewarn "transcoding engine enabled when you only have mencoder)."
}
