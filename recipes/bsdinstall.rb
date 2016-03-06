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

env = {
  'DISTRIBUTIONS'       => node['image']['bsdinstall']['distributions'],
  'BSDINSTALL_DISTDIR'  => node['image']['bsdinstall']['distdir'],
  'BSDINSTALL_DISTSITE' => node['image']['bsdinstall']['distsite'],
  'BSDINSTALL_CHROOT'   => node['image']['bsdinstall']['chroot'],
}

template '/etc/installerconfig' do
  owner 'root'
  group 'wheel'
  mode 0644
  variables(
    :distributions => node['image']['bsdinstall']['distributions'],
    :distdir       => node['image']['bsdinstall']['distdir'],
    :distsite      => node['image']['bsdinstall']['distsite'],
    :chroot        => node['image']['bsdinstall']['chroot'],
    :install       => node['image']['packages'].select{|_,v| v == 'install' }.keys,
  )
end

execute 'bsdinstall distfetch' do
  command 'bsdinstall distfetch > /dev/ttyv0'
  environment env
  not_if do
    node['image']['bsdinstall']['distributions'].split(' ').all? do |file|
      ::File.exist?(::File.join(node['image']['bsdinstall']['distdir'], file))
    end
  end
end

execute 'bsdinstall script' do
  command 'bsdinstall script /etc/installerconfig > /dev/ttyv0'
  environment env
end

execute 'bsdinstall mount' do
  environment env
end

[ '', '_dsa', '_ecdsa', '_rsa', '_ed25519' ].each do |algo|
  cookbook_file "#{node['image']['bsdinstall']['chroot']}/etc/ssh/ssh_host#{algo}_key" do
    owner 'root'
    group 'wheel'
    mode 0600
    action :create
  end
  cookbook_file "#{node['image']['bsdinstall']['chroot']}/etc/ssh/ssh_host#{algo}_key.pub" do
    owner 'root'
    group 'wheel'
    mode 0644
    action :create
  end
end

execute 'bsdinstall umount' do
  environment env
end

# vim: set ts=2 sw=2 et:
