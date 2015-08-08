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

  context "created with defaults" do
    its(:client) { should be_an_instance_of SODA::Client }
    its(:dataset_id) { should eq('ijzp-q8t2') }
    its(:query) { should be_an_instance_of Hash }
  end

  describe '#where' do
    subject { @dataset.where("beat = '0624'", "year = '2013'")}

    it 'concatenates queries with AND' do
      expect(subject["$where"]).to eq("beat = '0624' AND year = '2013'")
    end
    
    it 'returns hash' do
      expect(subject).to eq({"$where" => "beat = '0624' AND year = '2013'"})
    end
  end

  describe '#limit' do
    context 'when called with fixnum' do
      subject { @dataset.limit(5) }

      it 'returns hash with string' do
        expect(subject["$limit"]).to eq("5")
      end

      it 'returns correct hash' do
        expect(subject).to eq({"$limit" => "5"})
      end
    end

    context 'when called with string' do
      subject { @dataset.limit("1") }

      it 'returns correct hash' do
        expect(subject).to eq({"$limit" => "1"})
      end
    end
  end

  describe '#select' do
    context 'when called with multiple arguments' do
      subject { @dataset.select('date', 'ward') }

      it 'concatenates with ,' do
        expect(subject["$select"]).to eq("date, ward")
      end
    end

    context 'when called with 1 argument' do
      subject { @dataset.select('date') }
      
      it 'returns correct hash' do
        expect(subject).to eq({"$select" => "date"})
      end
    end
  end

  describe '#order' do
    context 'when called with without order' do
      subject { @dataset.order("id") }

      it 'should default to ascending' do
        expect(subject["$order"]).to eq("id ASC")
      end

      it 'should return correct hash' do
        expect(subject).to eq({"$order" => "id ASC"})
      end
    end

    context 'when called with order = DESC' do
      subject { @dataset.order("id", :DESC) }

      it 'should should return correct hash' do
        expect(subject).to eq({"$order" => "id DESC"})
      end
    end
  end

  describe '#query', focus: true do

  end
end
