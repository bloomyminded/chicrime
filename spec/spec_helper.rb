$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
Coveralls.wear!

require 'chicrime'
require 'pry'

RSpec.configure do |c|
    c.filter_run_including :focus => true
end
