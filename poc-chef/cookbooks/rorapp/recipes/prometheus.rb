user "prometheus" do
  shell '/bin/nologin'
end

bash 'extract_module' do
  cwd '/tmp'
  code <<-EOH
    for dir in /etc/prometheus /var/lib/prometheus; do
    mkdir -p $dir
    chown prometheus:prometheus $dir
    done
    wget https://github.com/prometheus/prometheus/releases/download/v2.3.2/prometheus-2.3.2.linux-amd64.tar.gz
    tar xvf prometheus-2.3.2.linux-amd64.tar.gz
    cp -r prometheus-2.3.2.linux-amd64/* /etc/prometheus/
    ln -s /etc/prometheus/prometheus /usr/local/bin/prometheus
    ln -s /etc/prometheus/promtool /usr/local/bin/promtool
    EOH
  not_if { ::File.exist?("/etc/prometheus") }
end

template "/etc/prometheus/prometheus.yml" do
  source "prometheus.yml.erb"
  owner 'prometheus'
  group 'prometheus'
  variables(hosts: node['hosts'])
  mode '0644'
end

cookbook_file '/etc/systemd/system/prometheus.service' do
  source 'prometheus.service'
  mode '0644'
end

systemd_unit 'prometheus.service' do
  action [:enable, :restart]
end
