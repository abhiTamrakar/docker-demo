include_recipe 'fluent::fluentd'

fluentd_cfg 'inputs' do
  content <<~EOT
    <source>
      @type debug_agent
      @id input_debug_agent
      bind 127.0.0.1
      port 24230
    </source>
  EOT
  notifies :reload, 'service[td-agent]', :delayed
end

fluentd_cfg 'outputs' do
  content <<~EOT
    <match debug.**>
      @type stdout
      @id output_stdout
    </match>
  EOT
  notifies :reload, 'service[td-agent]', :delayed
end

fluentd_gem 'fluent-plugin-grep'
