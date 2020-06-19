# frozen_string_literal: true

class ReactionRoleContainer < BaseCommandContainer
  extend Discordrb::EventContainer

  command :addreactionrole,
          aliases: [:arr],
          min_args: 3,
          max_args: 3,
          description: "Add a new reaction role to a message",
          usage: "addreactionrole <message_id> :emoji: <role_id>" do |event, message_id, emoji, role_id|
    # Validate message actually exists
    message = event.channel.load_message(message_id)
    return "Please supply a message_id from this channel" unless message

    # Only allow emoji from this server/generally available
    is_custom_emoji = (/\p{Emoji}/ =~ emoji).present?

    if is_custom_emoji
      # Parse out emoji id
      incoming_id = /.*:(\d*)/.match(emoji)[1]

      # Attempt to find that emoji in this server
      emojis = event.server.emojis
      match = emojis.select do |key, _|
        key == incoming_id
      end

      return "Please supply a emoji from this server" if match.keys.count.zero?
    end

    # TODO: only allow valid roles

    # Actually add the new reaction role
    ReactionRole.create!(
      message_id: message_id,
      reaction: emoji,
      role_id: role_id
    )

    return "\"#{role_id}\" sucessfully linked to #{emoji} for \"#{message_id}\""
  end
end
