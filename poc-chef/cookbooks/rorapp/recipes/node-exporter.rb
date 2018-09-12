user "node_exporter" do
  shell '/bin/nologin'
end

bash 'extract_module' do
  cwd '/tmp'
  code <<-EOH
    mkdir -p /etc/node_exporter/
    chown node_exporter:node_exporter /etc/node_exporter/
    wget https://github.com/prometheus/node_exporter/releases/download/v0.16.0/node_exporter-0.16.0.linux-amd64.tar.gz
    tar xvf node_exporter-0.16.0.linux-amd64.tar.gz
    cp -r node_exporter-0.16.0.linux-amd64/* /etc/node_exporter/
    ln -s /etc/node_exporter/node_exporter /usr/local/bin/node_exporter
    EOH
  not_if { ::File.exist?("/etc/node_exporter") }
end

cookbook_file '/etc/systemd/system/node_exporter.service' do
  source 'node_exporter.service'
  mode '0644'
end

systemd_unit 'node_exporter.service' do
  action [:enable, :restart]
end
