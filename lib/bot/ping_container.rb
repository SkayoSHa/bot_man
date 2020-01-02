# frozen_string_literal: true

module PingContainer
  extend Discordrb::Commands::CommandContainer

  command :ping, description: "Responds with 'Pong!'", do |event|
    event.respond("Pong!")
  end
end
