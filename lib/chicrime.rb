require "chicrime/version"
require "soda/client"

module Chicrime
  class Dataset
    attr_accessor :client, :query
    attr_reader :dataset_id

    def initialize token=''
      @client = SODA::Client.new({:domain => 'data.cityofchicago.org', :app_token => token})
      @dataset_id = 'ijzp-q8t2'
      @query = {}
    end

    def where *args
      query = args.count > 0 ? args * " AND " : ""
      {"$where" => "#{query}"}
    end

    def where_query *args
      query = args * " AND "
      if args.count > 0
        @client.get(@dataset_id, {"$where" => "#{query}"}) 
      else
        @client.get(@dataset_id, {})
      end
    end

    def select_query *args
      query = args * ","
      if args.count > 0
        @client.get(@dataset_id, {"$select" => "#{query}"}) 
      else
        @client.get(@dataset_id, {})
      end
    end

    def limit_query n
      @client.get(@dataset_id, {"$limit" => "#{n}"})
    end

    def order_query column, order="ASC"
      @client.get(@dataset_id, {"$order" => "#{column} #{order}"})
    end

  end
end
