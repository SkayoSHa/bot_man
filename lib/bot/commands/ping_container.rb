# frozen_string_literal: true

class PingContainer < BaseCommandContainer
  command :ping, description: "Responds with 'Pong!'" do |event|
    event.respond("Pong!")
  end
end
