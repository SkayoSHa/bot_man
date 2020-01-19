# frozen_string_literal: true

class PresenceContainer < BaseEventContainer
  playing do |event|
    pp event.details
    pp event.game
    pp event.server
    pp event.type
    pp event.url
    pp event.user
  end
end
