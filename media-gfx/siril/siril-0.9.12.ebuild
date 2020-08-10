# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="a free astronomical image processing software"
HOMEPAGE="https://www.siril.org/"
SRC_URI="https://gitlab.com/free-astro/siril/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/libconfig[cxx]
	media-libs/giflib
	media-libs/libpng:0=
	media-libs/libraw:=
	media-libs/opencv:=
	media-libs/tiff:0=
	media-video/ffmpeg:=
	sci-libs/cfitsio
	sci-libs/fftw:3.0=
	sci-libs/gsl
	virtual/jpeg:0
	>=x11-libs/gtk+-3.6.0:3
	"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
