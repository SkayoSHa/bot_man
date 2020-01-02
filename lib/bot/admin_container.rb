# frozen_string_literal: true

module AdminContainer
  extend Discordrb::Commands::CommandContainer

  command(:exit, help_available: false) do |event|
    break unless event.user.id == 147930850091073536

    event.respond("Bot is shutting down")
    exit
  end
end
