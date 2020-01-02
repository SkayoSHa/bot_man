# frozen_string_literal: true

namespace :discord do
  desc "Starts the Discord bot"
  task bot: :environment do
    raise "BOTMAN_BOT_TOKEN not set" unless ENV["BOTMAN_BOT_TOKEN"]

    require "discordrb"

    bot = Discordrb::Commands::CommandBot.new(
      token: ENV["BOTMAN_BOT_TOKEN"],
      prefix: "!"
    )

    bot.include! AdminContainer
    bot.include! InfoContainer
    bot.include! PingContainer
    bot.include! PrivateContainer
    bot.include! PresenceContainer


    if ENV["IS_DEV"]
      # Here we output the invite URL to the console so the bot account can be invited to the channel.
      # This only has to be done once
      puts "This bot's invite URL is #{bot.invite_url}."
      puts 'Click on it to invite it to your server.'
    end

    bot.run
  end

  desc "Starts the Discord bot without the rails environment"
  task :bot_no_env do
    raise "BOTMAN_BOT_TOKEN not set" unless ENV["BOTMAN_BOT_TOKEN"]

    require "discordrb"

    bot = Discordrb::Commands::CommandBot.new(
      token: ENV["BOTMAN_BOT_TOKEN"],
      prefix: "!"
    )

    require "bot/commands/admin_container"
    require "bot/commands/info_container"
    require "bot/commands/ping_container"
    require "bot/commands/private_container"
    require "bot/events/presence_container"

    bot.include! AdminContainer
    bot.include! InfoContainer
    bot.include! PingContainer
    bot.include! PrivateContainer
    bot.include! PresenceContainer

    if ENV["IS_DEV"]
      # Here we output the invite URL to the console so the bot account can be invited to the channel.
      # This only has to be done once
      puts "This bot's invite URL is #{bot.invite_url}."
      puts 'Click on it to invite it to your server.'
    end

    bot.run
  end
end
