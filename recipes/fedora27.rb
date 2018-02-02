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

template "#{root}/root/bootstrap.d/50-systemd.sh" do
  source 'bootstrap/systemd.erb'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

template "#{root}/etc/locale.conf" do
  owner 'root'
  group 'root'
  mode 0644
  variables :locale => node['image']['locale']
  action :create
end

directory "#{root}/etc/systemd/network" do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

['10-ens3.network','10-brU.netdev','10-brU.network'].each do |file|
  cookbook_file "#{root}/etc/systemd/network/#{file}" do
    owner 'root'
    group 'root'
    mode 0644
    action :create
  end
end

execute 'Use systemd-resolved' do
  command [
    'sed',
    '-e', 's/^\(hosts:[ \t]*\).*/\1files resolve [!UNAVAIL=return] dns myhostname/',
    '-i', "#{root}/etc/nsswitch.conf"
  ]
end

file "#{root}/etc/nsswitch.conf.bak" do
  action :delete
end

execute 'Disable DNSSEC' do
  command [
    'sed',
    '-e', '/^#*DNSSEC=/cDNSSEC=no',
    '-i', "#{root}/etc/systemd/resolved.conf"
  ]
end

link "#{root}/etc/resolv.conf" do
  to '/run/systemd/resolve/resolv.conf'
  action :create
end

# vim: set ts=2 sw=2 et:
