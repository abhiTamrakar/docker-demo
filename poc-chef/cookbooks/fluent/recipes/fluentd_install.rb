#
# Cookbook:: fluent
# Recipe:: fluentd_install
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

apt_repository 'td-agent' do
  uri 'http://packages.treasuredata.com/3/ubuntu/xenial/'
  key 'https://packages.treasuredata.com/GPG-KEY-td-agent'
  distribution 'xenial'
  components ['contrib']
  only_if { platform?('ubuntu') }
end

yum_repository 'td-agent' do
  description 'Treasure Data Agent repo'
  baseurl 'http://packages.treasuredata.com/3/redhat/\$releasever/\$basearch'
  gpgkey 'https://packages.treasuredata.com/GPG-KEY-td-agent'
  only_if { platform_family?('rhel') }
end

package 'td-agent'
