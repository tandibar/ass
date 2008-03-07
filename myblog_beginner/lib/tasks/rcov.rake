require 'rcov/rcovtask'

namespace :test do 
  namespace :coverage do
    desc "Delete aggregate coverage data."
    task(:clean) do
      rm_f "coverage.data"
      rm_f "coverage"
    end
  end
  
  namespace :rcov do
    desc "Runs all the tests through rcov"
    Rcov::RcovTask.new(:all => "db:test:prepare") do |t|
      t.libs << "test"
      test_files = []
      %w[unit functional integration performance helper].each { |target| test_files << FileList["test/#{target}/*_test.rb"] }
      t.test_files = test_files
      t.output_dir = "coverage"
      t.verbose = true
      t.rcov_opts << '--html --exclude boot.rb'
    end
  end

end
