# This file is part of kitchen-qemu-images.
# Copyright 2016 Emil Renner Berthing <esmil@esmil.dk>
#
# kitchen-qemu-images is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# kitchen-qemu-images is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with kitchen-qemu-images.  If not, see <http://www.gnu.org/licenses/>.

node.default['image']['bsdinstall']['distributions'] = 'kernel.txz base.txz'
node.default['image']['bsdinstall']['distdir']       = '/tmp'
node.default['image']['bsdinstall']['distsite']      =
  'ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/10.2-RELEASE'
node.default['image']['bsdinstall']['chroot']        = '/mnt'

node.default['image']['packages']['ca_root_nss'] = 'install'
node.default['image']['packages']['sudo']        = 'install'
