namespace :test do
	desc "Run tests and show coverage"
  task :coverage do
    require 'simplecov'
    Rake::Task["test"].execute
  end
end