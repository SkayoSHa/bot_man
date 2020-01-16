# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :discord,
           ENV['DISCORD_CLIENT_ID'],
           ENV['DISCORD_CLIENT_SECRET'],
           scope: 'connections email identify guilds'
end
