AppleMusic.configure do |config|
  config.secret_key = ENV['apple_private_key']
  config.team_id    = ENV['apple_team_key']
  config.music_id   = ENV['apple_app_key']
end