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

node.default['image']['dnf']['releasever'] = 27
node.default['image']['dnf']['repos']      = ['fedora','updates']

node.default['image']['grub']['cmdline-default'] = "rootfstype=#{node['image']['rootfstype']} rootwait audit=0"

node.default['image']['packages']['fedora-release']      = 'include'
node.default['image']['packages']['dnf']                 = 'include'

node.default['image']['packages']['initscripts']         = 'install'
node.default['image']['packages']['e2fsprogs']           = 'install'
node.default['image']['packages']['passwd']              = 'install'
node.default['image']['packages']['sudo']                = 'install'
node.default['image']['packages']['vim-minimal']         = 'install'
node.default['image']['packages']['grub2']               = 'install'
node.default['image']['packages']['grubby']              = 'install'
node.default['image']['packages']['kernel']              = 'install'
node.default['image']['packages']['openssh-server']      = 'install'
node.default['image']['packages']['openssh-clients']     = 'install'

node.default['image']['systemd']['dnf-makecache.timer']        = 'disable'
node.default['image']['systemd']['remote-fs.target']           = 'disable'
node.default['image']['systemd']['serial-getty@ttyS0.service'] = 'enable'
node.default['image']['systemd']['systemd-networkd.service']   = 'enable'
node.default['image']['systemd']['systemd-resolved.service']   = 'enable'
node.default['image']['systemd']['systemd-timesyncd.service']  = 'enable'
node.default['image']['systemd']['sshd.service']               = 'enable'

# vim: set ts=2 sw=2 et:
