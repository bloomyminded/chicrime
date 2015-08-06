require "chicrime/version"
require "soda/client"

module Chicrime
  class Dataset
    attr_accessor :client
    attr_reader :dataset_id

    def initialize token=''
      @client = SODA::Client.new({:domain => 'data.cityofchicago.org', :app_token => token})
      @dataset_id = 'x2n5-8w5q'
    end

  end
end
