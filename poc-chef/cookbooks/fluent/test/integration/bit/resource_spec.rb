control 'fluent_bit_cfg' do
  describe file('/etc/td-agent-bit/conf.d/inputs.conf') do
    its('content') do
      should match <<~EOT
        [INPUT]
            Name cpu
            Tag my_cpu
            Interval_Sec 300
      EOT
    end
  end

  describe file('/etc/td-agent-bit/conf.d/outputs.conf') do
    its('content') do
      should match <<~EOT
        [OUTPUT]
            Name null
            Match *
      EOT
    end
  end
end
