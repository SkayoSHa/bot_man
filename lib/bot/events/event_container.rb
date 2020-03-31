# frozen_string_literal: true

class EventContainer < BaseEventContainer
  raw do |event|
    # pp event.type

    # https://discordapp.com/developers/docs/topics/gateway#commands-and-events
    Event.create!(
      # server_uid: event.server&.id,
      type: event.type,
      data: event.data
    )
  end
end
