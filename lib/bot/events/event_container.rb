# frozen_string_literal: true

class EventContainer < BaseEventContainer
  raw do |event|
    # pp event.type

    # https://discordapp.com/developers/docs/topics/gateway#commands-and-events
    Event.create!(
      type: "Events::#{event.type.to_s.downcase.classify}Event",
      data: event.data
    )
  end
end
