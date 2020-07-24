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

    # Only allow valid roles
    roles = event.server.roles
    match = roles.select do |role|
      role.id.to_s == role_id
    end

    return "Please supply a role_id from this server" if match.count.zero?

    unless ReactionService.emoji_in_server(event.server, emoji)
      return "Please supply an emoji from this server"
    end

    # Add a reaction to the original message
    reaction_message = event.channel.load_message(message_id)

    reaction_key = ReactionService.reaction_key(emoji)
    reaction_message.create_reaction(reaction_key)

    # Don't allow the same ReactionRole to be added to the same message
    # using #find_or_create_by

    # Actually add the new reaction role
    reaction_role = ReactionRole.find_or_create_by(
      message_id: message_id,
      reaction: ReactionService.parse_emoji_key(emoji),
      role_id: role_id
    )
    reaction_role.save!

    # Delete the original triggering message
    event.message.delete

    response = "<@&#{role_id}> sucessfully linked to #{emoji} for [this message](#{discord_url(event.server.id, event.channel.id, message_id)})"

    embed = Discordrb::Webhooks::Embed.new(
      color: "#3FB426",
      description: response
    )

    event.bot.send_message(event.channel, "", false, embed)
    nil
  end

  command :removereactionrole,
          aliases: [:rrr],
          min_args: 2,
          max_args: 2,
          description: "Remove a reaction role from a message",
          usage: "removereactionrole <message_id> :emoji:" do |event, message_id, emoji|
    # Validate message actually exists
    message = event.channel.load_message(message_id)
    return "Please supply a message_id from this channel" unless message

    # Only allow emoji from this server/generally available
    unless ReactionService.emoji_in_server(event.server, emoji)
      return "Please supply an emoji from this server"
    end

    # Find the current reaction role
    reaction_role = ReactionRole.find_by(
      message_id: message_id,
      reaction: ReactionService.parse_emoji_key(emoji)
    )

    # Don't do anything if they didn't give a valid combination
    unless reaction_role
      return "Not a valid message/emoji combination."
    end

    # Delete the original triggering message
    event.message.delete

    response = "Sucessfully removed #{emoji} for [this message](#{discord_url(event.server.id, event.channel.id, message_id)})"

    # Remove all of that reaction on the message
    ReactionService.remove_reactions(
      message: message,
      emoji: emoji
    )

    # Actually delete the reaction_role
    reaction_role.delete

    embed = Discordrb::Webhooks::Embed.new(
      color: "#3FB426",
      description: response
    )

    event.bot.send_message(event.channel, "", false, embed)
    nil
  end

  reaction_add do |event|
    reaction_role = ReactionRole.where(
      message_id: event.message.id,
      reaction: ReactionService.parse_emoji_key(event.emoji.to_s)
    ).first

    return unless reaction_role

    event.user.add_role(reaction_role.role_id, "Adding reaction-based role")
  end

  reaction_remove do |event|
    reaction_role = ReactionRole.where(
      message_id: event.message.id,
      reaction: ReactionService.parse_emoji_key(event.emoji.to_s)
    ).first

    return unless reaction_role

    event.user.remove_role(reaction_role.role_id, "removing reaction-based role")
  end
end

def discord_url(server_id, channel_id, message_id)
  "https://discordapp.com/channels/#{server_id}/#{channel_id}/#{message_id}"
end
