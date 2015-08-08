require 'spec_helper'
require 'rspec/its'

describe Chicrime do
  it 'has a version number' do
    expect(Chicrime::VERSION).not_to be nil
  end
end

describe Chicrime::Dataset do

  before :all do
    @dataset = Chicrime::Dataset.new
  end

  subject { @dataset }

  it { should respond_to :where_query }

  context "created with defaults", focus: true do
    its(:client) { should be_an_instance_of SODA::Client }
    its(:dataset_id) { should eq('ijzp-q8t2') }
    its(:query) { should be_an_instance_of Hash }
  end

  describe '#where', focus: true do
    it 'concatenates queries with AND' do
      expect(subject.where("beat = '0624'", "year = '2013'")).to be_instance_of(Hash)
    end
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

    it 'returns an array of Hashie::Mash object(s) in an array' do
      expect(subject.select_query()).to be_instance_of(Array)
      expect(subject.select_query()[0]).to be_instance_of(Hashie::Mash)
    end
  end

  describe '#limit_query' do
    it 'returns n items in array' do
      expect(subject.limit_query(5).count).to eq(5)
    end
  end

  describe '#order_query' do
    it 'returns items in descending order' do
      data = subject.order_query("id", "DESC")
      expect(data[0].id).to be > data[1].id
    end

    it 'returns items in ascending order' do
      data = subject.order_query("id")
      expect(data[0].id).to be < data[1].id
    end
  end

end
