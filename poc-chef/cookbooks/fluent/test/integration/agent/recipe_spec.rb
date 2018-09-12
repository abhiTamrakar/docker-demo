control 'fluentd_install' do
  describe package('td-agent') do
    it { should be_installed }
  end
end

control 'fluentd_configure' do
  describe file('/etc/td-agent/td-agent.conf') do
    its('content') { should match '\@include conf.d\/\*\.conf' }
  end

  describe file('/etc/td-agent/conf.d/default.conf') do
    its('content') { should match 'log_level info' }
  end
end

control 'fluentd_manage' do
  describe service('td-agent') do
    it { should be_enabled }
    it { should be_running }
  end
end
