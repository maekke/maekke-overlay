# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils libtool multilib

MY_PV="${PV/_beta/beta}"
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="Beta release of TIFF4 (Tag Image File Format) image library."
HOMEPAGE="http://www.remotesensing.org/libtiff/"
SRC_URI="ftp://ftp.remotesensing.org/pub/libtiff/${PN}-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="+cxx jpeg jbig +largefile -mdi zlib"

DEPEND="jpeg? ( >=media-libs/jpeg-6b:0 )
	jbig? ( >=media-libs/jbigkit-1.6-r1 )
	zlib? ( >=sys-libs/zlib-1.1.3-r2 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.9.2-CVE-2009-2347.patch
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-silent-rules \
		$(use_enable cxx) \
		$(use_enable jbig) \
		$(use_enable jpeg) \
		$(use_enable largefile) \
		$(use_enable mdi) \
		$(use_enable static-libs static) \
		$(use_enable zlib) \
		--without-x \
		--with-docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO
	if ! use static-libs; then
		find "${D}"/usr/$(get_libdir) -name '*.la' -delete || die
	fi
}

pkg_postinst() {
	if use jbig; then
		echo
		elog "JBIG support is intended for Hylafax fax compression, so we"
		elog "really need more feedback in other areas (most testing has"
		elog "been done with fax).  Be sure to recompile anything linked"
		elog "against tiff."
		echo
	fi
}
