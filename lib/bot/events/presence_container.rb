# frozen_string_literal: true

module PresenceContainer
  extend Discordrb::EventContainer

  playing do |event|
    pp event.details
    pp event.game
    pp event.server
    pp event.type
    pp event.url
    pp event.user
  end
end
