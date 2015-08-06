require "chicrime/version"
require "soda/client"

module Chicrime
  class Dataset
    attr_accessor :client
    attr_reader :dataset_id

    def initialize token
      @client = SODA::Client.new({:domain => 'data.cityofchicago.org', :app_token => token})
      @dataset_id = 'ijzp-q8t2'
    end

    def id
    end

  end
end
