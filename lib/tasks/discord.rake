# frozen_string_literal: true

namespace :discord do
  def do_bot_run
    raise "BOTMAN_BOT_TOKEN not set" unless ENV["BOTMAN_BOT_TOKEN"]

    require "discordrb"

    bot = Discordrb::Commands::CommandBot.new(
      token: ENV["BOTMAN_BOT_TOKEN"],
      prefix: "!"
    )

    require Rails.root.join("lib", "bot", "commands", "base_container.rb")

    Dir["#{Rails.root.join("lib", "bot")}/**/*.rb"].each do |file_path|
      require file_path

      file_name = File.basename(file_path, ".rb")
      bot.include! file_name.classify.constantize
    end

    if ENV["IS_DEV"]
      # Here we output the invite URL to the console so the bot account can be invited to the channel.
      # This only has to be done once
      puts "This bot's invite URL is #{bot.invite_url}."
      puts 'Click on it to invite it to your server.'
    end

    bot.run
  end


  desc "Starts the Discord bot"
  task bot: :environment do
    do_bot_run
  end

  desc "Starts the Discord bot without the rails environment"
  task :bot_no_env do
    do_bot_run
  end
end
