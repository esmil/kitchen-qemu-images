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

node.default['image']['yum']['releasever'] = 7
node.default['image']['yum']['repos']      = [ 'base', 'updates' ]

node.default['image']['grub']['cmdline-default'] = "rootfstype=#{node['image']['rootfstype']} rootwait"

node.default['image']['packages']['centos-release']      = 'include'
node.default['image']['packages']['initscripts']         = 'include'
node.default['image']['packages']['yum']                 = 'include'
node.default['image']['packages']['systemd-networkd']    = 'include'
node.default['image']['packages']['systemd-resolved']    = 'include'

node.default['image']['packages']['passwd']              = 'install'
node.default['image']['packages']['sudo']                = 'install'
node.default['image']['packages']['vim-minimal']         = 'install'
node.default['image']['packages']['grub2']               = 'install'
node.default['image']['packages']['grubby']              = 'install'
node.default['image']['packages']['kernel']              = 'install'
node.default['image']['packages']['openssh-server']      = 'install'
node.default['image']['packages']['openssh-clients']     = 'install'

node.default['image']['systemd']['systemd-readahead-collect.service'] = 'disable'
node.default['image']['systemd']['systemd-readahead-replay.service']  = 'disable'
node.default['image']['systemd']['remote-fs.target']                  = 'disable'
node.default['image']['systemd']['serial-getty@ttyS0.service']        = 'enable'
node.default['image']['systemd']['systemd-networkd.service']          = 'enable'
node.default['image']['systemd']['systemd-resolved.service']          = 'enable'
node.default['image']['systemd']['sshd.service']                      = 'enable'
node.default['image']['systemd']['network.service']                   = 'disable'
node.default['image']['systemd']['syslog.socket']                     = 'mask'

# vim: set ts=2 sw=2 et:
