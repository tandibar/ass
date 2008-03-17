require 'active_support'

namespace :test do
  desc "Displays the test methods of each test case in a human readable format"
  task :agiledox do
    include ActiveSupport::CoreExtensions::String::Inflections
    
    tests = FileList['test/**/*_test.rb']
    tests.each do |file|
      m = %r(.*/([^/].*)_test.rb).match(file)
      puts "#{m[1].camelcase} should:\n" 
      test_definitions = File::readlines(file).select {|line| line =~ /.*def test.*/}
      test_definitions.each do |definition|
        m = %r(test_(should_)?(.*)).match(definition)
        puts " - #{m[2].gsub(/_/,' ')}"
      end
      puts "\n" 
    end
  end
end

