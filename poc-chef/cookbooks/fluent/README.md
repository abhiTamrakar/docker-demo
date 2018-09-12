# fluent cookbook [![Build Status](https://travis-ci.org/nathwill/chef-fluent.svg?branch=master)](https://travis-ci.org/nathwill/chef-fluent)

simple cookbook for managing td-agent{,-bit} (fluent{d,bit})

## recipes

- default: install, configure, manage td-agent

- fluentd: install, configure, manage td-agent
- fluent_bit: install, configure, manage td-agent-bit

- fluentd_install: install td-agent
- fluentd_configure: configure td-agent debug input, set up include dir
- fluentd_manage: manage td-agent service

- fluent_bit_install: install td-agent-bit
- fluent_bit_configure: configure td-agent-bit, set up include mgmt
- fluent_bit_manage: manage td-agent-bit service

## resources

### fluentd\_cfg

light wrapper of the file resource, sets default path of `/etc/td-agent/conf.d/#{name}.conf`

example:

```ruby
fluentd_cfg 'input' do
  content <<~EOT
    <source>
      @type debug_agent
      @id input_debug_agent
      bind 127.0.0.1
      port 24230
    </source>
  EOT
end
```

### fluent\_bit\_cfg

light wrapper of the file resource, sets default path of `/etc/td-agent-bit/conf.d/#{name}.conf`

```ruby
fluent_bit_cfg 'input' do
  content <<~EOT
    [INPUT]
        Name cpu
        Tag my_cpu
        Interval_Sec 300
  EOT
end
```

### fluentd\_gem

light wrapper of the gem_package resource, sets default gem_binary to `/usr/sbin/td-agent-gem`

example:

```ruby
fluentd_gem 'fluent-plugin-grep' do
  version '0.3.4'
end
```
