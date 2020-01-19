# frozen_string_literal: true

class MassMoveContainer < BaseContainer
  command :massmove, description: "Moves all users in a voice channel to another voice channel", usage: 'massmove [source_channel] [destination_channel]' do |event, source_channel_name, dest_channel_name|
    voice_channels = event.server.voice_channels
    server = event.server

    source_channel = closest_channel(source_channel_name, voice_channels)
    dest_channel = closest_channel(dest_channel_name, voice_channels)

    users = source_channel.users
    user_count = users.count

    users.each do |user|
      server.move(user, dest_channel)
    end

    "Moving #{user_count} #{"user".pluralize(user_count)} to #{dest_channel.name}"
  end
end

def closest_channel(text, channels)
  closest = nil
  dist = 999_999

  channels.each do |channel|
    l = lev(text, channel.name)

    if l < dist
      dist = l
      closest = channel
    end
  end

  closest
end

def lev(string1, string2, memo={})
  return memo[[string1, string2]] if memo[[string1, string2]]
  return string2.size if string1.empty?
  return string1.size if string2.empty?
  min = [ lev(string1.chop, string2, memo) + 1,
          lev(string1, string2.chop, memo) + 1,
          lev(string1.chop, string2.chop, memo) + (string1[-1] == string2[-1] ? 0 : 1)
      ].min
  memo[[string1, string2]] = min
  min
end
