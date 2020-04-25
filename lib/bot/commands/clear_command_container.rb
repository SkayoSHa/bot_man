# frozen_string_literal: true

class ClearCommandContainer < BaseCommandContainer
  extend Discordrb::EventContainer

  command(
    :clear,
    min_args: 1,
    max_args: 1,
    description: "Clears a number of messages in the channel",
    usage: "clear [number of messages]",
    help_available: true
  ) do |event, num_messages|
    return "Please supply number of messages" unless num_messages

    num_messages = num_messages.to_i

    # Only allow a valid number of messagesto be deleted
    unless num_messages >= 2 && num_messages < 100
      return "Number of messages must be between 2 and 100"
    end

    # Make sure that the user is an admin
    return "Permission denied." unless event.user.permission?(:administrator)

    # Delete the messages
    event.channel.prune(num_messages)

    ""
  end
end
