# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

control 'packer' do
  impact 0.6
  title 'Packer should be installed'
  desc 'Packer should be installed and configured'
  tag 'packer'

  describe package('packer') do
    it { should be_installed }
  end

end
