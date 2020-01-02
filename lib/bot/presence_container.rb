# frozen_string_literal: true

module PresenceContainer
  extend Discordrb::Commands::CommandContainer

  command :ping, description: "Responds with 'Pong!'" do |event|
    event.respond("Pong!")
  end
end
