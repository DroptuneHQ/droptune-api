source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

# Framework
gem "rails", "~> 7.0.4"

# Data
gem "pg", "~> 1.1"

# Webserver
gem "puma", "~> 5.0"

# API
gem "jbuilder"
gem "rack-cors"

# Caching
gem "redis", "~> 4.0"

# Background Processing
gem "sidekiq"
gem "sidekiq-throttled"
gem "sidekiq-cron"
gem "sidekiq-unique-jobs"
gem "sidekiq-failures"

# Music Services
gem "rspotify"
gem "musicbrainz"

# Miscellaneous
gem "figaro" # environment variables

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]