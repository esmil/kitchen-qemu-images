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

node.default['image']['debootstrap']['distro']     = 'debian'
node.default['image']['debootstrap']['codename']   = 'wheezy'
node.default['image']['debootstrap']['components'] = ['main','contrib','non-free']
node.default['image']['debootstrap']['mirror']     = 'http://mirror.one.com'

node.default['image']['grub']['cmdline-default'] = "rootfstype=#{node['image']['rootfstype']} rootwait"

node.default['image']['packages']['locales']                = 'install'
node.default['image']['packages']['iproute']                = 'install'
node.default['image']['packages']['ifupdown']               = 'install'
node.default['image']['packages']['net-tools']              = 'install'
node.default['image']['packages']['bridge-utils']           = 'install'
node.default['image']['packages']['isc-dhcp-client']        = 'install'
node.default['image']['packages']['sudo']                   = 'install'
node.default['image']['packages']['ca-certificates']        = 'install'
node.default['image']['packages']['curl']                   = 'install'
node.default['image']['packages']['openssh-server']         = 'install'
node.default['image']['packages']['acpi-support-base']      = 'install'
node.default['image']['packages']['grub-pc']                = 'install'
node.default['image']['packages']['linux-image-amd64']      = 'install'

node.default['image']['packages']['debconf-i18n']           = 'purge'
node.default['image']['packages']['libtext-wrapi18n-perl']  = 'purge'
node.default['image']['packages']['libtext-iconv-perl']     = 'purge'
node.default['image']['packages']['liblocale-gettext-perl'] = 'purge'
node.default['image']['packages']['libtext-charwidth-perl'] = 'purge'

# vim: set ts=2 sw=2 et:
