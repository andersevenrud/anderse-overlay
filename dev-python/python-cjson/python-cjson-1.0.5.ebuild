# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Very fast JSON encoder/decoder for Python"
HOMEPAGE="http://pypi.python.org/pypi/python-cjson/
	http://ag-projects.com/"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" jsontest.py
	}
	python_execute_function testing
}
