# frozen_string_literal: true

class TempVoiceCommandContainer < BaseCommandContainer
  extend Discordrb::EventContainer

  command(
    :createjumpchannel,
    min_args: 1,
    max_args: 1,
    description: "Creates a new temporary voice jump channel",
    usage: "createjumpchannel [jump channel name]",
    help_available: false
  ) do |event, jump_channel_name|
    return "Please supply a jump channel name" unless jump_channel_name

    UserService.ensure_user(event.user)

    # Make sure that the user is an admin
    break unless event.user.permission?(:administrator)

    server = event.server

    # Make the new channel
    new_channel = server.create_channel(
      jump_channel_name,
      2, # type
      reason: "Creating temporary voice jump channel"
    )

    # Record information to DB
    TemporaryVoiceChannel.create!(
      server_uid: event.server.id,
      creator_uid: event.user.id,
      channel_uid: new_channel.id,
      is_jump_channel: true,
      active: true
    )

    "Temporary jump channel \"#{jump_channel_name}\" created"
  end
end
