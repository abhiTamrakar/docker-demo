name 'fluent'
maintainer 'Nathan Williams'
maintainer_email 'nath.e.will@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures fluentd-agent'
long_description 'Installs/Configures fluentd-agent'
version '1.0.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

supports 'centos', '~> 7.0'
supports 'ubuntu', '~> 16.04'

issues_url 'https://github.com/nathwill/chef-fluent/issues'
source_url 'https://github.com/nathwill/chef-fluent'
