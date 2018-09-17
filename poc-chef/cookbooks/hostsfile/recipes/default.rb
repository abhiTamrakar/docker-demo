hostsfile_entry "#{node['ipaddress']}" do
  hostname 'localhost'
  action :create
end
