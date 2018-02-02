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

root = node['image']['mountpoint']

link "#{root}/etc/mtab" do
  to '/proc/mounts'
end

execute 'fix inittab' do
  command ['sed', '-e', 's/^\([13-7]\):/#\1:/',
                  '-e', 's/^2:[^:]*:/2:2345:/',
                  '-e', 's/^#*T0:/T0:/',
                  '-i', "#{root}/etc/inittab"]
end

directory "#{root}/etc/network" do
  owner 'root'
  group 'root'
  mode 0755
end

template "#{root}/etc/network/interfaces" do
  owner 'root'
  group 'root'
  mode 0644
  variables :ifname => (node['image']['debootstrap']['ifname'] || 'eth0')
  action :create
end

# vim: set ts=2 sw=2 et:
