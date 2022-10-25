web: bundle exec puma -p $PORT -C config/puma.rb
worker: bundle exec sidekiq -e ${RAILS_ENV:-development} -C config/sidekiq.yml -q default