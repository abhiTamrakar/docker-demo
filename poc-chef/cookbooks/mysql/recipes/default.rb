#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mysql_service 'server' do
  port '3306'
  version '5.7'
  initial_root_password node['dbpassword']
  action [:create, :start]
end

file 'db.conf' do
  content "[client]
user=#{node['dbuser']}
password=#{node['dbpassword']}
socket=/var/run/mysql-server/mysqld.sock"
  mode '0600'
end

execute 'mysql|configure grant' do
  command "mysql --defaults-extra-file=db.conf -e \"GRANT ALL ON *.* to #{node['dbuser']}@'%' IDENTIFIED BY #{node['dbpassword']};\""
end

execute 'mysql|configure grant flush' do
  command "mysql --defaults-extra-file=db.conf -e \"FLUSH PRIVILEGES;\""
end
