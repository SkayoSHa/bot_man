# frozen_string_literal: true

class TempVoiceCommandContainer < BaseCommandContainer
  extend Discordrb::EventContainer

  command(
    :createjumpchannel,
    min_args: 1,
    description: "Creates a new temporary voice jump channel",
    usage: "createjumpchannel [jump channel name]",
    help_available: false
  ) do |event, *jump_channel_array|
    jump_channel_name = jump_channel_array.join(" ")
    return "Please supply a jump channel name" unless jump_channel_name

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

    "Temporary jump channel `#{jump_channel_name}` created"
  end

  command(
    :deletejumpchannel,
    min_args: 1,
    description: "Deletes a temporary voice jump channel",
    usage: "deletejumpchannel [jump channel name]",
    help_available: false
  ) do |event, *jump_channel_array|
    jump_channel_name = jump_channel_array.join(" ")
    return "Please supply a jump channel name" unless jump_channel_name

    # Make sure that the user is an admin
    break unless event.user.permission?(:administrator)

    server = event.server

    # Find the actual reference to the discord channel
    discord_jump_channel =
      server.voice_channels.detect { |c| c.name == jump_channel_name }

    # If it's a jump channel
    jump_channel = TemporaryVoiceChannel.where(
      server_uid: server.id,
      channel_uid: discord_jump_channel.id,
      is_jump_channel: true,
      active: true
    ).first

    return unless jump_channel

    # Mark the channel as inactive
    jump_channel.update!(active: false)

    # Delete the channel
    discord_jump_channel.delete

    "Temporary jump channel `#{jump_channel_name}` deleted"
  end
end
