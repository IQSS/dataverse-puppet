require 'spec_helper'
describe 'iqss' do

  context 'with defaults for all parameters' do
    it { should contain_class('iqss') }
  end
end
