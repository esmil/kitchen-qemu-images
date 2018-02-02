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

execute 'apt-get update' do
  command ['apt-get', '-q', 'update']
end

package 'debootstrap' do
  action :install
end

cmd = ['debootstrap']
cmd.push("--arch=#{node['image']['debootstrap']['arch']}") if node['image']['debootstrap']['arch']
cmd.push("--variant=#{node['image']['debootstrap']['variant']}") if node['image']['debootstrap']['variant']
cmd.push("--components=#{node['image']['debootstrap']['components'].join(',')}") if node['image']['debootstrap']['components']
pkgs = node['image']['packages'].select{|_,v| v == 'include'}.keys
cmd.push("--include=#{pkgs.join(',')}") unless pkgs.empty?
pkgs = node['image']['packages'].select{|_,v| v == 'exclude'}.keys
cmd.push("--exclude=#{pkgs.join(',')}") unless pkgs.empty?
cmd.push(node['image']['debootstrap']['codename'], root,
         "#{node['image']['debootstrap']['mirror']}/#{node['image']['debootstrap']['distro']}/")

execute 'debootstrap' do
  command cmd
  not_if { File.file?("#{root}/etc/debian_version") }
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

file "#{root}/etc/hostname" do
  action :delete
end

cookbook_file "#{root}/etc/hosts" do
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

file "#{root}/etc/resolv.conf" do
  content ''
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

template "#{root}/etc/apt/sources.list" do
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

cookbook_file "#{root}/etc/apt/apt.conf.d/06norecommends" do
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

directory "#{root}/root/bootstrap.d" do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

template "#{root}/root/bootstrap.d/20-packages.sh" do
  source 'bootstrap/apt.erb'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

if ['include','install'].include? node['image']['packages']['grub-pc']
  template "#{root}/root/bootstrap.d/30-grub.sh" do
    source 'bootstrap/grub.erb'
    owner 'root'
    group 'root'
    mode 0644
    action :create
  end
end

file "#{root}/etc/timezone" do
  content "#{node['image']['timezone']}\n"
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

file "#{root}/root/bootstrap.d/80-tzdata.sh" do
  content "dpkg-reconfigure -fnoninteractive tzdata\n"
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

template "#{root}/etc/default/locale" do
  source 'locale.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :locale => node['image']['locale']
  action :create
end

template "#{root}/root/bootstrap.d/81-locales.sh" do
  source 'bootstrap/locales.erb'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# vim: set ts=2 sw=2 et:
