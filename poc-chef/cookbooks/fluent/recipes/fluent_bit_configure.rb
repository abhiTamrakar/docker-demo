#
# Cookbook:: fluent
# Recipe:: fluent_bit_configure
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

directory '/etc/td-agent-bit/conf.d'

fluent_bit_cfg 'default' do
  content <<~EOT
    [SERVICE]
        Parsers_File /etc/td-agent-bit/parser.conf
  EOT
end

Chef.event_handler do
  on :resource_updated do |resource, _|
    if resource.to_s.start_with?('fluent_bit_cfg[')
      FluentCookbook::Helpers.update_fluent_bit_includes
    end
  end
end
