# frozen_string_literal: true

class TempVoiceEventContainer < BaseEventContainer
  extend Discordrb::EventContainer

  voice_state_update do |event|
    # Don't do anything if they're leaving the channel
    next unless event.channel

    server = event.server

    # If it's a jump channel
    jump_channel = TemporaryVoiceChannel.where(
      server_uid: server.id,
      channel_uid: event.channel.id,
      is_jump_channel: true,
      active: true
    ).first

    next unless jump_channel

    # Find the actual reference to the discord channel
    discord_jump_channel =
      server.voice_channels.detect { |channel| channel.id == event.channel.id }

    # Make the new channel
    new_channel = server.create_channel(
      "~#{event.user.name}",
      2, # type
      reason: "Creating temporary voice channel"
    )

    # Move it to be below the jump channel
    new_channel.sort_after(discord_jump_channel, true)

    # Record information to DB
    TemporaryVoiceChannel.create!(
      server_uid: server.id,
      creator_uid: event.user.id,
      channel_uid: new_channel.id,
      is_jump_channel: false,
      active: true
    )

    # Move the user to the new channel
    server.move(event.user, new_channel)
  end
end
