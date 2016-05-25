

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl_rails'
require 'helpers/with_stubbed_pmb'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end
require 'mocha/mini_test'
