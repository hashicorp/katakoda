# Copyright IBM Corp. 2017, 2026
# SPDX-License-Identifier: MPL-2.0

control 'nomad' do
  impact 0.6
  title 'Nomad should be installed'
  desc 'Nomad should be installed and configured'
  tag 'nomad'

  describe package('nomad') do
    it { should be_installed }
  end

end
