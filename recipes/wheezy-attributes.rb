# This file is part of kitchen-qemu-images.
# Copyright 2016,2018 Emil Renner Berthing <esmil@esmil.dk>
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
node.default['image']['debootstrap']['codename']   = 'wheezy'
node.default['image']['debootstrap']['components'] = ['main','contrib','non-free']
node.default['image']['debootstrap']['mirror']     = 'https://deb.debian.org'

node.default['image']['grub']['cmdline-default'] = "rootfstype=#{node['image']['rootfstype']} rootwait"

node.default['image']['packages']['ca-certificates']     = 'include'
node.default['image']['packages']['apt-utils']           = 'include'
node.default['image']['packages']['apt-transport-https'] = 'include'

node.default['image']['packages']['perl-modules']        = 'install'
node.default['image']['packages']['locales']             = 'install'
node.default['image']['packages']['iproute']             = 'install'
node.default['image']['packages']['ifupdown']            = 'install'
node.default['image']['packages']['net-tools']           = 'install'
node.default['image']['packages']['bridge-utils']        = 'install'
node.default['image']['packages']['isc-dhcp-client']     = 'install'
node.default['image']['packages']['sudo']                = 'install'
node.default['image']['packages']['curl']                = 'install'
node.default['image']['packages']['openssh-server']      = 'install'
node.default['image']['packages']['acpi-support-base']   = 'install'
node.default['image']['packages']['grub-pc']             = 'install'
node.default['image']['packages']['linux-image-amd64']   = 'install'
node.default['image']['packages']['python']              = 'install'

# vim: set ts=2 sw=2 et:
