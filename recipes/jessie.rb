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

root = node['image']['mountpoint']

link "#{root}/etc/systemd/system/getty.target.wants/getty@tty1.service" do
  to '/lib/systemd/system/getty@.service'
  action :delete
end

link "#{root}/etc/systemd/system/getty.target.wants/getty@tty2.service" do
  to '/lib/systemd/system/getty@.service'
  action :create
end

link "#{root}/etc/systemd/system/getty.target.wants/serial-getty@ttyS0.service" do
  to '/lib/systemd/system/serial-getty@.service'
  action :create
end

link "#{root}/etc/systemd/system/syslog.socket" do
  to '/dev/null'
  action :create
end

link "#{root}/etc/systemd/system/default.target" do
  to '../lib/systemd/system/multi-user.target'
  action :create
end

# vim: set ts=2 sw=2 et:
