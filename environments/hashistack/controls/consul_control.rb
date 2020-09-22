control 'Consul' do
  impact 0.6
  title 'Consul should be installed'
  desc 'Consul should be installed and configured'
  tag 'consul'

  describe package('consul') do
    it { should be_installed }
  end

  describe package('azure-cli') do
    it { should be_installed }
  end

  describe user('consul') do
    it { should exist }
  end

  [
    'counting-service',
    'dashboard-service',
    'consul-template',
    'envconsul',
  ].each do |binary|
    describe file("/usr/local/bin/#{binary}") do
      it { should be_executable }
    end
  end

end
