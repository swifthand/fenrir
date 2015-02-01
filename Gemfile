source 'https://rubygems.org'

ruby "2.1.5"


gem 'rails', '4.1.9'
gem 'rake'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'

gem 'pg'
gem 'unicorn'

gem 'awesome_print'

gem 'virtus'

# In-browser error console in development mode.
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
end

group :development, :staging, :test do
  gem 'ansi' # Color for turn tests.
  gem 'minitest-reporters'
end

group :production, :staging do
  gem 'rails_12factor'
end
