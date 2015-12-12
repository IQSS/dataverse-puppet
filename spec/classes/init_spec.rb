require 'spec_helper'
describe 'dataverse' do

  context 'with defaults for all parameters' do
    it { should contain_class('dataverse') }
  end
end
