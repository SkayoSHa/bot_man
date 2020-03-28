# frozen_string_literal: true

class TempVoiceEventContainer < BaseEventContainer
  extend Discordrb::EventContainer

  voice_state_update do |event|
    # Don't do anything if they're leaving the channel
    if event.channel
      handle_channel_join(event)
    else
      handle_channel_leave(event)
    end
  end

  def self.handle_channel_join(event)
    server = event.server
    channel = event.channel

    # If it's a jump channel
    jump_channel = TemporaryVoiceChannel.where(
      server_uid: server.id,
      channel_uid: channel.id,
      is_jump_channel: true,
      active: true
    ).first

    return unless jump_channel

    # Find the actual reference to the discord channel
    discord_jump_channel =
      server.voice_channels.detect { |c| c.id == channel.id }

    # Make the new channel
    new_channel = server.create_channel(
      "~#{event.user.name}",
      2, # type
      reason: "Creating temporary voice channel"
    )

    # Move it to be below the jump channel
    new_channel.sort_after(discord_jump_channel, true)

    # Give the user manage_channels for the temp channel
    allow = Discordrb::Permissions.new [:manage_channels]
    new_channel.define_overwrite(event.user, allow)

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

  def self.handle_channel_leave(event)
    server = event.server
    old_channel = event.old_channel

    # If it's a temp channel
    temp_channel = TemporaryVoiceChannel.where(
      server_uid: server.id,
      channel_uid: old_channel.id,
      is_jump_channel: false,
      active: true
    ).first

    return unless temp_channel

    # Find the actual reference to the discord channel
    discord_temp_channel =
      server.voice_channels.detect { |c| c.id == old_channel.id }

    # Check to see if anyone else is in the channel
    return unless discord_temp_channel.users.empty?

    # Mark the channel as inactive
    temp_channel.update!(active: false)

    # Delete the channel
    discord_temp_channel.delete
  end
end
