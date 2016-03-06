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

directory "#{root}/etc/ssh" do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

[ 'dsa', 'ecdsa', 'rsa', 'ed25519' ].each do |algo|
  cookbook_file "#{root}/etc/ssh/ssh_host_#{algo}_key" do
    owner 'root'
    group 'root'
    mode 0600
    action :create
  end
  cookbook_file "#{root}/etc/ssh/ssh_host_#{algo}_key.pub" do
    owner 'root'
    group 'root'
    mode 0644
    action :create
  end
end

template "#{root}/root/bootstrap" do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

bash 'bootstrap' do
  code <<-EOF
mount --bind /dev  '#{root}/dev'
mount --bind /proc '#{root}/proc'
mount --bind /sys  '#{root}/sys'
mount --bind /etc/resolv.conf '#{root}/etc/resolv.conf'
chroot '#{root}' /root/bootstrap 2>&1
status="$?"
umount '#{root}/etc/resolv.conf'
umount '#{root}/sys'
umount '#{root}/proc'
umount '#{root}/dev'
exit $status
  EOF
end

# vim: set ts=2 sw=2 et:
