package %w(software-properties-common apt-transport-https default-jre) do
  action :install
end

execute "install | download deb package" do 
  command 'wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.4.0-amd64.deb && dpkg -i metricbeat-6.4.0-amd64.deb'
  cwd "/tmp/"
end

template "/etc/metricbeat/metricbeat.yml" do 
  source 'metricbeat.yml.erb'
  owner 'root'
  group 'root'
  mode '0640'
  variables(ext_ip: node['ext_ip'],
           es_host: node['es_host'])
  action :create
end

directory "/etc/metricbeat/modules.d" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

node['modules'].each do |mod|

template "/etc/metricbeat/modules.d/#{mod}.yml" do
  source "metrics-#{mod}.yml.erb"
  owner 'root'
  group 'root'
  mode '0644'
  variables(dbhost: node['dbhost'],
            dbpassword: node['dbpassword'],
            dbuser: node['dbuser'],
            metrics_host: node['metrics_host'],
            mysql_host: node['mysql_host'],
            es_host: node['es_host'])
  action :create
end

end

systemd_unit 'metricbeat.service' do
  action [:enable, :restart]
end

execute 'metricbeat setup' do
  action :run
  ignore_failure true
end
