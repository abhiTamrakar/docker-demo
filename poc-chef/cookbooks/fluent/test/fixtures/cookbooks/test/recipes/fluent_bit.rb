include_recipe 'fluent::fluent_bit'

fluent_bit_cfg 'inputs' do
  content <<~EOT
    [INPUT]
        Name cpu
        Tag my_cpu
        Interval_Sec 300
  EOT
  notifies :restart, 'service[td-agent-bit]', :delayed
end

fluent_bit_cfg 'outputs' do
  content <<~EOT
    [OUTPUT]
        Name null
        Match *
  EOT
  notifies :restart, 'service[td-agent-bit]', :delayed
end
