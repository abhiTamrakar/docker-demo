package %w(software-properties-common apt-transport-https default-jre) do
  action :install
end

user 'install | create user' do
  username 'elasticsearch'
  shell '/bin/nologin'
end

execute "install | download deb package" do 
  command "wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-#{node['es_version']}.deb && dpkg -i elasticsearch-#{node['es_version']}.deb"
  cwd "/tmp/"
end

cookbook_file "/etc/elasticsearch/elasticsearch.yml" do 
  source 'elasticsearch.yml'
  owner 'elasticsearch'
  group 'elasticsearch'
  mode '0755'
  action :create
end

systemd_unit 'elasticsearch.service' do
  action [:enable, :start]
end
