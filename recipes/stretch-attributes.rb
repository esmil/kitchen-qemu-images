# This file is part of kitchen-qemu-images.
# Copyright 2018 Emil Renner Berthing <esmil@esmil.dk>
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

node.default['image']['debootstrap']['distro']     = 'debian'
node.default['image']['debootstrap']['codename']   = 'stretch'
node.default['image']['debootstrap']['components'] = ['main','contrib','non-free']
node.default['image']['debootstrap']['mirror']     = 'https://deb.debian.org'

node.default['image']['grub']['cmdline-default'] = "rootfstype=#{node['image']['rootfstype']} rootwait"

node.default['image']['packages']['ca-certificates']     = 'include'
node.default['image']['packages']['apt-utils']           = 'include'
node.default['image']['packages']['apt-transport-https'] = 'include'

node.default['image']['packages']['systemd-sysv']        = 'install'
node.default['image']['packages']['libpam-systemd']      = 'install'
node.default['image']['packages']['libnss-myhostname']   = 'install'
node.default['image']['packages']['libnss-resolve']      = 'install'
node.default['image']['packages']['perl-modules']        = 'install'
node.default['image']['packages']['locales']             = 'install'
node.default['image']['packages']['iproute2']            = 'install'
node.default['image']['packages']['sudo']                = 'install'
node.default['image']['packages']['wget']                = 'install'
node.default['image']['packages']['openssh-server']      = 'install'
node.default['image']['packages']['linux-image-amd64']   = 'install'
node.default['image']['packages']['grub-pc']             = 'install'
node.default['image']['packages']['python']              = 'install'

node.default['image']['systemd']['serial-getty@ttyS0.service'] = 'enable'
node.default['image']['systemd']['systemd-networkd.service']   = 'enable'
node.default['image']['systemd']['systemd-resolved.service']   = 'enable'
node.default['image']['systemd']['systemd-timesyncd.service']  = 'enable'

# vim: set ts=2 sw=2 et:
