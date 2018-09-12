#
# Cookbook:: fluent
# Recipe:: fluent_bit_install
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

apt_repository 'td-agent-bit' do
  uri 'http://packages.fluentbit.io/ubuntu'
  key 'http://packages.fluentbit.io/fluentbit.key'
  distribution 'xenial'
  components ['main']
  only_if { platform?('ubuntu') }
end

yum_repository 'td-agent-bit' do
  description 'TD Agent Bit repo'
  baseurl 'http://packages.fluentbit.io/centos/\$releasever'
  gpgkey 'http://packages.fluentbit.io/fluentbit.key'
  only_if { platform_family?('rhel') }
end

package 'td-agent-bit'
