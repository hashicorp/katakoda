control 'vault' do
  impact 0.6
  title 'Vault should be installed'
  desc 'Vault should be installed and configured'
  tag 'vault'

  describe package('vault') do
    it { should be_installed }
  end

end
