control 'fluentd_cfg' do
  describe file('/etc/td-agent/conf.d/inputs.conf') do
    its('content') do
      should match <<~EOT
        <source>
          @type debug_agent
          @id input_debug_agent
          bind 127.0.0.1
          port 24230
        </source>
      EOT
    end
  end

  describe file('/etc/td-agent/conf.d/outputs.conf') do
    its('content') do
      should match <<~EOT
        <match debug.**>
          @type stdout
          @id output_stdout
        </match>
      EOT
    end
  end
end

control 'fluentd_gem' do
  describe command('/usr/sbin/td-agent-gem list') do
    its('stdout') { should match 'fluent-plugin-grep' }
  end
end
