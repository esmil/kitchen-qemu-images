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

package 'dnf' do
  action :install
end

cmd = [ 'dnf', '-y', '--best', "--installroot=#{root}", '--disablerepo=*' ]
cmd.push("--releasever=#{node['image']['dnf']['releasever']}") if node['image']['dnf']['releasever']
node['image']['dnf']['repos'].each do |repo|
  cmd.push("--enablerepo=#{repo}")
end
cmd.push('install')
node['image']['packages'].each_pair do |pkg, action|
  cmd.push(pkg) if action == 'include'
end

execute 'dnf' do
  command cmd
  not_if { File.file?("#{root}/etc/system-release") }
end

template "#{root}/etc/fstab" do
  owner 'root'
  group 'root'
  variables :fstab => [
    {
      'device'     => '/dev/sda1',
      'mountpoint' => '/',
      'fstype'     => node['image']['rootfstype'],
      'options'    => node['image']['fs'][node['image']['rootfstype']]['options'],
      'freq'       => 1,
      'passno'     => 1,
    }
  ]
  mode 0644
end

directory "#{root}/root/bootstrap.d" do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

template "#{root}/root/bootstrap.d/20-packages.sh" do
  source 'bootstrap/dnf.erb'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

if node['image']['packages']['grub2'] == 'include' ||
   node['image']['packages']['grub2'] == 'install'
  template "#{root}/root/bootstrap.d/30-grub.sh" do
    source 'bootstrap/grub.erb'
    owner 'root'
    group 'root'
    mode 0644
    action :create
  end
end

# vim: set ts=2 sw=2 et:
