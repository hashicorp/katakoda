control 'terraform' do
  impact 0.6
  title 'Terraform should be installed'
  desc 'Terraform should be installed and configured'
  tag 'terraform'

  describe package('terraform') do
    it { should be_installed }
  end

  # Installed from Zip
  [
    'sentinel',
  ].each do |binary|
    describe file("/usr/local/bin/#{binary}") do
      it { should be_executable }
    end
  end

end
