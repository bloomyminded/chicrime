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

  it { should respond_to :where_query }

  context "created with defaults" do
    its(:client) { should be_an_instance_of SODA::Client }
    its(:dataset_id) { should eq('ijzp-q8t2') }
  end

  describe '#where_query' do
    it 'concatentates queries with AND' do
      expect(subject.where_query("beat = '0624'", "year = '2013'")).to be_instance_of(Array)
    end

    it 'returns an array of Hashie::Mash object(s)' do
      expect(subject.where_query()).to be_instance_of(Array)
    end
  end

  describe '#select_query' do
    it 'concatenates queries with ','' do
      expect(subject.select_query("date, ward, id, domestic")).to be_instance_of(Array)
    end

    it 'returns an array of Hashie::Mash object(s)' do
      expect(subject.select_query()).to be_instance_of(Array)
    end
  end

  describe '#limit_query' do
    it 'returns n items in array' do
      expect(subject.limit_query(5).count).to eq(5)
    end
  end

end
