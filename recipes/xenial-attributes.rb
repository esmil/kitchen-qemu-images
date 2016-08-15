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

node.default['image']['debootstrap']['distro']     = 'ubuntu'
node.default['image']['debootstrap']['codename']   = 'xenial'
node.default['image']['debootstrap']['components'] = ['main','restricted','universe']
node.default['image']['debootstrap']['mirror']     = 'http://archive.ubuntu.com'
node.default['image']['debootstrap']['ifname']     = 'ens3'

node.default['image']['grub']['cmdline-default'] = "rootfstype=#{node['image']['rootfstype']} rootwait"

node.default['image']['packages']['iproute2']            = 'install'
node.default['image']['packages']['ifupdown']            = 'install'
#node.default['image']['packages']['net-tools']           = 'install'
node.default['image']['packages']['bridge-utils']        = 'install'
node.default['image']['packages']['isc-dhcp-client']     = 'install'
node.default['image']['packages']['sudo']                = 'install'
node.default['image']['packages']['ca-certificates']     = 'install'
node.default['image']['packages']['curl']                = 'install'
node.default['image']['packages']['openssh-server']      = 'install'
node.default['image']['packages']['acpi-support']        = 'install'
node.default['image']['packages']['grub-pc']             = 'install'
node.default['image']['packages']['linux-image-generic'] = 'install'

node.default['image']['packages']['makedev']             = 'purge'

node['image']['locale']['generate'].each do |locale|
  lang = locale.match(/^([^_]*)/)[1]
  node.default['image']['packages']["language-pack-#{lang}"] = 'install'
end

node.default['image']['systemd']['getty@tty1.service']         = 'disable'
node.default['image']['systemd']['getty@tty2.service']         = 'enable'
node.default['image']['systemd']['serial-getty@ttyS0.service'] = 'enable'
node.default['image']['systemd']['syslog.socket']              = 'mask'


# vim: set ts=2 sw=2 et:
