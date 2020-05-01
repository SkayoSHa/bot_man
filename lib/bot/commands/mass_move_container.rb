# frozen_string_literal: true

class MassMoveContainer < BaseCommandContainer
  command :massmove, aliases: [:mm], min_args: 2, max_args: 2, description: "Moves all users in a voice channel to another voice channel", usage: "massmove [source_channel] [destination_channel]" do |event, source_channel_name, dest_channel_name|
    voice_channels = event.server.voice_channels
    server = event.server

    source_channel = closest_channel(source_channel_name, voice_channels)
    dest_channel = closest_channel(dest_channel_name, voice_channels)

    users = source_channel.users
    user_count = users.count

    users.each do |user|
      server.move(user, dest_channel)
    end

    "Moving #{user_count} #{'user'.pluralize(user_count)} to #{dest_channel.name}"
  end

  def self.closest_channel(text, channels)
    source = text.downcase.tr("^0-9a-z", "")

    closest = nil
    dist = 999_999

    channels.each do |channel|
      target = channel.name.downcase.tr("^0-9a-z", "")

      # Pick this channel if there's a direct substring
      return channel if check_substring(source, target)

      l = lev(source, target)

      if l < dist
        dist = l
        closest = channel
      end
    end

    closest
  end

  def self.lev(string1, string2, memo = {})
    return memo[[string1, string2]] if memo[[string1, string2]]
    return string2.size if string1.empty?
    return string1.size if string2.empty?

    min = [
      lev(string1.chop, string2, memo) + 1,
      lev(string1, string2.chop, memo) + 1,
      lev(string1.chop, string2.chop, memo) + (string1[-1] == string2[-1] ? 0 : 1)
    ].min

    memo[[string1, string2]] = min
    min
  end

  def self.check_substring(source, target)
    target.include? source
  end
end
