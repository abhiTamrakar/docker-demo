# Cookbook:: fluent
# Recipe:: fluentd_configure
#
# Copyright:: 2018, Nathan Williams
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

directory '/etc/td-agent/conf.d'

fluentd_cfg 'default' do
  content <<~EOT
    <system>
      log_level info
    </system>
    <source>
      @type forward
      @id input_forward
      port 24224
      bind 0.0.0.0
    </source>
  EOT
end

file '/etc/td-agent/td-agent.conf' do
  content "@include conf.d/*.conf\n"
end

if node['fluentd']['node_type'] == "server"

template '/etc/td-agent/conf.d/server.conf' do
  source 'server.conf.erb'
  mode 0644
  variables(es_host: node['es_host'])
end

else

template '/etc/td-agent/conf.d/client.conf' do
  source 'client.conf.erb'
  mode 0644
  variables(es_host: node['es_host'])
end

cookbook_file '/etc/td-agent/conf.d/extra.conf' do
  source 'client-input.conf'
  mode 0644
end

end
