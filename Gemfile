source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'jbuilder'

gem 'pg'

gem 'uglifier', '>= 1.3.0'
gem 'react_on_rails', '~> 6'

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring', require: false
  gem 'listen', '~> 3.0'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'mocha'
end
