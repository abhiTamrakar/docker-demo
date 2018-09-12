name 'mysql'
maintainer 'Abhishek Tamrakar'
maintainer_email 'abhishek_tamrakar@persistent.com'
license 'Apache License 2.0'
description 'Installs/Configures mysql'
long_description 'Installs/Configures mysql'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
depends 'mysql', '~> 8.0'
