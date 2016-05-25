source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem 'mysql2'
gem 'activeuuid'
# Use SCSS for stylesheets and bootstrap for styling
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'

gem 'will_paginate'
gem "will_paginate-bootstrap"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0', require: false

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby, require: false

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem "puma"

# Add simple support for print-my barcode)
gem 'pmb-client', '0.1.0', :github => 'sanger/pmb-client'

# We're using faraday for our HTTP client as its already
# being used by one of our other dependencies (pmb-client).
gem "faraday"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'binding.pry' anywhere in the code to stop execution and get a repl console
  gem 'pry'
  gem 'mocha'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

gem 'simplecov', require: false, group: :test

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

end

