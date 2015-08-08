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
      @query.store("$where", "#{query}")
      self
    end

    def limit n
      query = n
      @query.store("$limit", "#{query}")
      self
    end
    
    def select *args
      query = args.count > 0 ? args * ', ' : ''
      @query.store("$select", "#{query}")
      self
    end

    def order column, order=:ASC
      @query.store("$order", "#{column} #{order}")
      self
    end

    def results 
      @client.get(@dataset_id, @query)
    end
  end
end
