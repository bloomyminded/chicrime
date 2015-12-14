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
      @soql = {}
      instance_eval(&block)
      results
    end

    # TODO: only respond when called inside where block
    def method_missing m, *args, &block 
      if soql["$where"]
        prev = soql["$where"] + " AND"
        q = "#{prev} #{m} #{args[0]} #{args[1]}".strip
        @soql.store("$where", "#{q}")
      else
        q = "#{m} #{args[0]} #{args[1]}".strip
        @soql.store("$where", "#{q}")
      end
    end

    def where *args, &block
      if block_given?
        instance_eval(&block)
      else
        q = args.count > 0 ? args * " AND " : ""
        @soql.store("$where", "#{q}")
      end

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

    def search str
      @soql.store("$q", "#{str}")
      self
    end

    def results 
      @client.get(@dataset_id, @soql)
    end

    def equals data
      "= #{data}"
    end

    def greater_than data
      "> #{data}"
    end

    def less_than data
      "< #{data}"
    end

    def not_equal data
      "!= #{data}"
    end
  end
end
