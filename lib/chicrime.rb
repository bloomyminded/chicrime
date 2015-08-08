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

    def limit n
      query = n
      {"$limit" => "#{query}"}
    end
    
    def select *args
      query = args.count > 0 ? args * ', ' : ''
      {"$select" => "#{query}"}
    end

    def order column, order=:ASC
      {"$order" => "#{column} #{order}"}
    end

    def order_query column, order="ASC"
      @client.get(@dataset_id, {"$order" => "#{column} #{order}"})
    end

  end
end
