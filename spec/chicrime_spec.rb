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

  describe '#select', focus: true do
    context 'when called with multiple arguments' do
      subject { @dataset.select('date', 'ward') }

      it 'concatenates with ,' do
        expect(subject["$select"].to eq("date, ward"))
      end
    end

    context 'when called with 1 argument' do
      subject { @dataset.select('date') }
      
      it 'returns correct hash' do
        expect(subject).to eq({"$select" => "date"})
      end
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
