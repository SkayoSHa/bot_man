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
    is_custom_emoji = emoji.include? ":"

    if is_custom_emoji
      # Parse out emoji id
      incoming_id = /.*:(\d*)/.match(emoji)[1]

      # Attempt to find that emoji in this server
      emojis = event.server.emojis
      match = emojis.select do |key, _|
        key.to_s == incoming_id
      end

      return "Please supply an emoji from this server" if match.count.zero?
    end

    # Only allow valid roles
    roles = event.server.roles
    match = roles.select do |role|
      role.id.to_s == role_id
    end

    return "Please supply a role_id from this server" if match.count.zero?

    # Don't allow the same ReactionRole to be added to the same message
    # using #find_or_create_by

    # Actually add the new reaction role
    reaction_role = ReactionRole.find_or_create_by(
      message_id: message_id,
      reaction: emoji,
      role_id: role_id
    )
    reaction_role.save!

    # Delete the original triggering message
    event.message.delete

    message = "<@&#{role_id}> sucessfully linked to #{emoji} for [this message](#{discord_url(event.server.id, event.channel.id, message_id)})"

    embed = Discordrb::Webhooks::Embed.new(
      color: "#3FB426",
      description: message
    )

    event.bot.send_message(event.channel, "", false, embed)
    nil
  end
end

def discord_url(server_id, channel_id, message_id)
  "https://discordapp.com/channels/#{server_id}/#{channel_id}/#{message_id}"
end
