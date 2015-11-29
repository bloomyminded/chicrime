require "chicrime/version"
require "soda/client"

module Chicrime
  class Dataset
    attr_accessor :client, :soql
    attr_reader :dataset_id

    def initialize token=''
      @client = SODA::Client.new({:domain => 'data.cityofchicago.org', :app_token => token})
      @dataset_id = 'ijzp-q8t2'
      @soql = {}
    end

    def query &block
      instance_eval(&block)
      results
    end

    #def method_missing m, op=:AND, *args, &block
    #  q = args.count > 0 ? args * " #{op} " : ""
    #  @soql.store("$#{m}", "#{q}")
    #end

    def where op=:AND, *args
      q = args.count > 0 ? args * " #{op} " : ""
      @soql.store("$where", "#{q}")
      self
    end

    def limit n
      @soql.store("$limit", "#{n}")
      self
    end
    
    def select *args
      q = args.count > 0 ? args * ', ' : ''
      @soql.store("$select", "#{q}")
      self
    end

    def order column, order=:ASC
      @soql.store("$order", "#{column} #{order}")
      self
    end

    def results 
      puts @soql
      @client.get(@dataset_id, @soql)
    end
  end
end
