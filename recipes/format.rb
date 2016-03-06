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

package 'util-linux' do
  action :install
end

if node['image']['uefi']
  efidev  = "#{node['image']['blockdev']}1"
  rootdev = "#{node['image']['blockdev']}2"
  cmd = [
    'g',
    'n', '1', '', (node['image']['efi-mb']*1024*2-1).to_s,
    'n', '2', '', '',
    't', '1', '1',
    't', '2', '18',
    'w'
  ]
else
  rootdev = "#{node['image']['blockdev']}1"
  cmd = ['o', 'n', 'p', '1', '', '', 'a', '1', 'w']
end

bash 'fdisk' do
  code "echo -e '#{cmd.join('\n')}' | fdisk '#{node['image']['blockdev']}'"
  not_if { File.blockdev?(rootdev) }
end

if node['image']['uefi']
  package 'dosfstools' do
    action :upgrade
  end
  execute 'mkfs-efi' do
    command ['mkfs.vfat', '-f32', '-n', 'EFI', efidev]
    not_if { node['filesystem'][efidev] }
  end
end

case node['image']['rootfstype']
when 'ext4'
  package 'e2fsprogs' do
    action :upgrade
  end
  cmd = ['mkfs.ext4', '-L', 'root', rootdev]
when 'xfs'
  package 'xfsprogs' do
    action :upgrade
  end
  cmd = ['mkfs.xfs', '-L', 'root', rootdev]
end

execute 'mkfs-root' do
  command cmd
  not_if { node['filesystem'][rootdev] }
end

mount node['image']['mountpoint'] do
  device rootdev
  fstype node['image']['rootfstype']
  options node['image']['fs'][node['image']['rootfstype']]['options']
end

if node['image']['uefi']
  directory "#{node['image']['mountpoint']}/boot/efi" do
    owner 'root'
    group 'root'
    mode 0755
    action :create
    recursive true
  end

  mount node['image']['mountpoint'] do
    device efidev
    fstype 'vfat'
    options ['noatime', 'discard', 'iocharset=iso8859-15', 'utf8', 'tz=UTC', 'dmask=0022', 'fmask=0133']
  end
end

# vim: set ts=2 sw=2 et:
