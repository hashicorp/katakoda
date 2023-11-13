# Copyright (c) HashiCorp, Inc.
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
