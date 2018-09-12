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
