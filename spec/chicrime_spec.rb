require 'spec_helper'
require 'rspec/its'

describe Chicrime do
  it 'has a version number' do
    expect(Chicrime::VERSION).not_to be nil
  end
end

describe Chicrime::Dataset do

  before :all do
    @data = Chicrime::Dataset.new('3iKjVXIj6i2Qj1oeEPr4kRqY2')
  end

  subject { @data }

  context "created with defaults" do
    its(:client) { should be_an_instance_of SODA::Client }
    its(:dataset_id) { should eq('x2n5-8w5q') }
  end

end
