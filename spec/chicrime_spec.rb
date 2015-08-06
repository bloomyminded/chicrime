require 'spec_helper'
require 'rspec/its'

describe Chicrime do
  it 'has a version number' do
    expect(Chicrime::VERSION).not_to be nil
  end
end

describe Chicrime::Dataset do

  before :all do
    @dataset = Chicrime::Dataset.new('3iKjVXIj6i2Qj1oeEPr4kRqY2')
  end

  subject { @dataset }

  it { should respond_to :id }

  context "created with defaults" do
    its(:client) { should be_an_instance_of SODA::Client }
    its(:dataset_id) { should eq('ijzp-q8t2') }
  end

  describe '#id' do
    it 'returns Hashie::Map object for crime with given id' do
      pending        
    end
  end

end
