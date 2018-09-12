#
# Cookbook Name:: fluent
# Library:: FluentCookbook
#
# Copyright 2018, Nathan Williams
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

module FluentCookbook
  class FluentdCfgResource < Chef::Resource::File
    resource_name :fluentd_cfg
    property :path, String, default: lazy { "/etc/td-agent/conf.d/#{name}.conf" }
  end

  class FluentdCfgProvider < Chef::Provider::File
    provides :fluentd_cfg
  end

  class FluentBitCfgResource < Chef::Resource::File
    resource_name :fluent_bit_cfg
    property :path, String, default: lazy { "/etc/td-agent-bit/conf.d/#{name}.conf" }
  end

  class FluentBitCfgProvider < Chef::Provider::File
    provides :fluent_bit_cfg
  end

  class FluentdGemResource < Chef::Resource::Package::GemPackage
    resource_name :fluentd_gem
    property :gem_binary, String, default: '/usr/sbin/td-agent-gem'
  end

  class FluentdGemProvider < Chef::Provider::Package::Rubygems
    provides :fluentd_gem
  end

  module Helpers
    module_function

    def update_fluent_bit_includes
      cfgs = Dir.glob('/etc/td-agent-bit/conf.d/*.conf')
      IO.write('/etc/td-agent-bit/td-agent-bit.conf',
               cfgs.map { |x| "@INCLUDE #{x}" }.join("\n"))
    end
  end
end
