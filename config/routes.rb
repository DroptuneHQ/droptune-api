require 'sidekiq_unique_jobs/web'
require 'sidekiq/cron/web'
require 'sidekiq/web'

Rails.application.routes.draw do
  resources :tweets
  resources :music_videos
  resources :albums
  mount Sidekiq::Web => '/sidekiq'

  resources :artists, only: [:index, :show, :create, :update, :destroy]

  resources :sources
end
