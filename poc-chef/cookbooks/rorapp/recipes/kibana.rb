package %w(software-properties-common apt-transport-https default-jre) do
  action :install
end

user 'install | create user' do
  username 'kibana'
  shell '/bin/nologin'
end

execute "install | download deb package" do 
  command 'wget https://artifacts.elastic.co/downloads/kibana/kibana-6.2.3-amd64.deb && dpkg -i kibana-6.2.3-amd64.deb'
  cwd "/tmp/"
end

template "/etc/kibana/kibana.yml" do 
  source 'kibana.yml.erb'
  owner 'kibana'
  group 'kibana'
  mode '0660'
  variables(ext_ip: node['ext_ip'],
           es_host: node['es_host'])
  action :create
end

systemd_unit 'kibana.service' do
  action [:enable, :start]
end
