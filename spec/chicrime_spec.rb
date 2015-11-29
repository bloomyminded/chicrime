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

  context "created with defaults" do
    its(:client) { should be_an_instance_of SODA::Client }
    its(:dataset_id) { should eq('ijzp-q8t2') }
    its(:soql) { should be_an_instance_of Hash }
  end

  describe '#where' do
    before { @dataset.where("beat = '0624'", "year = '2013'")}
    it { expect(@dataset.soql).to have_key("$where") }
  end

  describe '#limit' do
    before { @dataset.limit(1) }
    it { expect(@dataset.soql).to have_key("$limit") }
  end

  describe '#select' do
    before { @dataset.select('date') }
    it { expect(@dataset.soql).to have_key("$select") }
  end

  describe '#order' do
    before { @dataset.order('id') }
    it { expect(@dataset.soql).to have_key("$order") }
  end

  describe '#results' do
    before :each do
      @dataset.soql = {}
    end

    context 'when called with #where' do
      let(:data) { @dataset.where("year = 2013").results }
      it 'returns an array of Hashie::Map object(s) with given $where' do
        expect(data).to be_an_instance_of(Array)
        expect(data.sample).to be_an_instance_of(Hashie::Mash)
        expect(data.sample).not_to include("year" => "2014")
      end
    end

    context 'when called with #limit' do
      let(:data) { @dataset.limit(5).results }
      it 'returns an array of Hashie::Map object(s) with given $limit' do
        expect(data).to be_an_instance_of(Array)
        expect(data.sample).to be_an_instance_of(Hashie::Mash)
        expect(data.count).to eq(5) 
      end
    end

    context 'when called with #select' do
      let(:data) { @dataset.select("year").results }
      it 'returns an array of Hashie::Map object(s) with given $select' do
        expect(data).to be_an_instance_of(Array)
        expect(data.sample).to be_an_instance_of(Hashie::Mash)
        expect(data.sample).not_to have_key("id")
        expect(data.sample).to have_key("year")
      end
    end

    context 'when called with #order' do
      let(:data) { @dataset.order("id").results }
      it 'returns an array of Hashie::Map object(s) with given $order' do
        expect(data).to be_an_instance_of(Array)
        expect(data.sample).to be_an_instance_of(Hashie::Mash)
        expect(data[0][:id]).to be < data[1][:id]
      end
    end

    context 'when called with #where and #limit' do
      let(:data) { @dataset.where("year = 2013").limit(1).results }
      it 'returns an array of Hashie::Map object(s) with given $where & $limit' do
        expect(data).to be_an_instance_of(Array)
        expect(data.sample).to be_an_instance_of(Hashie::Mash)
        expect(data.count).to eq(1)
        expect(data.sample).not_to include("year" => "2005")
      end
    end
  end
end
