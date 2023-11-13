# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

control 'vault' do
  impact 0.6
  title 'Vault should be installed'
  desc 'Vault should be installed and configured'
  tag 'vault'

  describe package('vault') do
    it { should be_installed }
  end

  # Check for exit for IPC_LOCK in docker requirement
  describe command('vault -h') do
    its('exit_status') { should eq 0 }
  end

end
