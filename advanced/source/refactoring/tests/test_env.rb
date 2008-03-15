VERSION_TO_TEST = "v1.3"

require 'test/unit'
require "#{File.dirname(__FILE__)}/../#{VERSION_TO_TEST}/movie"
require "#{File.dirname(__FILE__)}/../#{VERSION_TO_TEST}/rental"
require "#{File.dirname(__FILE__)}/../#{VERSION_TO_TEST}/customer"
require "#{File.dirname(__FILE__)}/../#{VERSION_TO_TEST}/price" if VERSION_TO_TEST >= "v1.1"