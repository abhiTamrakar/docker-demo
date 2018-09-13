#
# Cookbook:: rorapp
# Recipe:: default
#

package %w(ruby ruby-dev ruby-bundler libmysqlclient-dev build-essential) do
  action :install
end

execute "gem install nio4r mysql2" do
  action :run
end

directory '/var/www/railsapp/' do
  recursive true
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  action :create
end

cookbook_file '/tmp/railsapp.zip' do
  source 'railsapp.zip'
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  action :create
end

execute 'unarchive the app' do
  command 'unzip /tmp/railsapp.zip && chown -R ubuntu:ubuntu ./*'
  cwd '/var/www/railsapp/'
  action :run
end

template '/var/www/railsapp/project_management_demo/config/database.yml' do
  source 'database.yml.erb'
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  variables(dbhost: node['dbhost'],
            dbpassword: node['dbpassword'],
            dbuser: node['dbuser'],
            dbname: node['dbname'])
end

execute 'bundle' do
  cwd '/var/www/railsapp/project_management_demo'
  user 'ubuntu'
  action :run
end

execute 'rake db:create' do
  cwd '/var/www/railsapp/project_management_demo'
  user 'ubuntu'
  action :run
end

execute 'rake db:migrate' do
  cwd '/var/www/railsapp/project_management_demo'
  user 'ubuntu'
  action :run
end

execute "nohup rails server -b 0.0.0.0 &" do
  cwd '/var/www/railsapp/project_management_demo'
  action :run
end
