control 'fluentbit_install' do
  describe package('td-agent-bit') do
    it { should be_installed }
  end
end

control 'fluentbit_configure' do
  describe file('/etc/td-agent-bit/td-agent-bit.conf') do
    its('content') { should match '@INCLUDE' }
  end

  describe file('/etc/td-agent-bit/conf.d/default.conf') do
    its('content') { should match 'Parsers_File /etc/td-agent-bit/parser.conf' }
  end
end

control 'fluentbit_manage' do
  describe service('td-agent-bit') do
    it { should be_enabled }
    it { should be_running }
  end
end
