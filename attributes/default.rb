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

default['image']['blockdev'] = '/dev/sdb'
default['image']['rootfstype'] = 'ext4'
default['image']['mountpoint'] = '/mnt'

default['image']['fs']['ext4']['options'] = ['noatime', 'discard']
default['image']['fs']['xfs']['options']  = ['noatime', 'discard', 'noquota']

default['image']['debootstrap']['arch']    = 'amd64'
default['image']['debootstrap']['variant'] = 'minbase'

default['image']['grub']['timeout'] = 0

default['image']['timezone']           = 'Etc/UTC'
default['image']['locale']['lang']     = 'en_US.UTF-8'
default['image']['locale']['generate'] = ['en_US.UTF-8 UTF-8']
