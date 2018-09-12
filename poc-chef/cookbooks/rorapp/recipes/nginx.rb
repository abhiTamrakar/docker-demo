apt_repository 'nginx' do
  uri 'https://nginx.org/packages/ubuntu/'
  components ['nginx']
  distribution 'xenial'
  key 'https://nginx.org/keys/nginx_signing.key'
  action :add
  deb_src true
end

package 'nginx' do
  action :install
end

template "/etc/nginx/conf.d/apps.conf" do
  source "apps.conf.erb"
  mode 0644
  variables(ext_ip: node['ext_ip'])
  not_if { File.exist?('/usr/sbin/nginx') }
end

systemd_unit 'nginx.service' do
  action [:enable, :restart]
end
