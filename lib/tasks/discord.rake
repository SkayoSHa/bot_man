# frozen_string_literal: true

namespace :discord do
  desc "Starts the Discord bot"
  task bot: :environment do
    raise "BOTMAN_BOT_TOKEN not set" unless ENV["BOTMAN_BOT_TOKEN"]

    require "discordrb"
    # require "bot/codes_container"
    require "bot/ping_container"

    bot = Discordrb::Commands::CommandBot.new(token: ENV["BOTMAN_BOT_TOKEN"], prefix: "!")

    bot.include! AdminContainer
    bot.include! InfoContainer
    bot.include! PingContainer
    bot.include! PrivateContainer

    if ENV["IS_DEV"]
      # Here we output the invite URL to the console so the bot account can be invited to the channel. This only has to be
      # done once, afterwards, you can remove this part if you want
      puts "This bot's invite URL is #{bot.invite_url}."
      puts 'Click on it to invite it to your server.'
    end

    bot.run
  end
end
