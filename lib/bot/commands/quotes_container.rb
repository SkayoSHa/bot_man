# frozen_string_literal: true

class QuotesContainer < BaseCommandContainer
  extend Discordrb::EventContainer

  command :addquote, aliases: [:aq], min_args: 2, description: "Records a new quote", usage: "addquote @<user> [the quote to add]" do |event, target_user_string, *quote|
    return "Please tag someone to quote" unless target_user_string
    return "Please add a quote" unless quote

    quote = quote.join(" ")

    target_user_id = target_user_string.delete("^0-9")
    target_user = event.server.member(target_user_id)
    return "Please tag someone to quote" unless target_user

    # Actually add the quote
    new_quote = Quote.create!(
      server_uid: event.server.id,
      quoter_uid: event.user.id,
      quotee_uid: target_user.id,
      quote: quote
    )

    # TODO: link the id returned to the frontend?
    "Quote ##{new_quote.id} successfully added"
  end

  command :quote, aliases: [:quotes], min_args: 0, max_args: 1, description: "Replays a quote", usage: "quote (@<user>|<id>)" do |event, target|
    # Return a random one, if target is nil
    quote = random_quote(server_id: event.server.id) if target.nil?

    unless quote
      key = target.delete("^0-9")

      target_user = event.server.member(key)

      # There was a user supplied
      if target_user
        quote = random_quote(server_id: event.server.id, user: target_user)
      end

      quote = Quote.find_by(server_uid: event.server.id, id: key)
    end

    return "No quote found." unless quote

    embed = embed_for(event, quote)
    event.bot.send_message(event.channel, "", false, embed)
    nil
  end

  reaction_add emoji: "quote" do |event|
    quote = event.message.text

    unless quote.empty?
      target_user = event.message.user

      is_new = Quote.where(
        server_uid: event.server.id,
        message_id: event.message.id
      ).count.zero?

      if is_new
        # Actually add the quote
        new_quote = Quote.create!(
          server_uid: event.server.id,
          quoter_uid: event.user.id,
          quotee_uid: target_user.id,
          quote: quote,
          message_id: event.message.id
        )

        # TODO: link the id returned to the frontend?
        event.bot.send_message(event.channel, "Quote ##{new_quote.id} successfully added")
      end
    end
  end

  command :removequote, min_args: 1, max_args: 1, description: "Removes a quote", usage: "removequote [the quote ID to remove]" do |event, quote_id|
    return "Please add the quote to remove" unless quote_id

    quote = Quote.find_by(server_uid: event.server.id, id: quote_id)

    return "Quote not found." unless quote

    if quote.quoter_uid == event.user.id || quote.quotee_uid == event.user.id
      quote.delete
    else
      return "Only the quote author or reporter can delete this quote."
    end

    # TODO: add confirmation?
    "Quote removed."
  end

  command :allquotes, min_args: 0, max_args: 1, description: "Removes a quote", usage: "allquotes (@<user>)" do |event, target_user_name|
    target_user_id = target_user_name&.delete("^0-9")
    target_user = event.server.member(target_user_id)

    quotes = Quote.where(server_uid: event.server.id)
    quotes = quotes.where(quotee_uid: target_user.id) if target_user
    quotes = quotes.order(:created_at)

    quotes.each do |quote|
      embed = embed_for(event, quote)
      event.bot.send_message(event.user.pm, "", false, embed)
    end

    "Please check your direct messages."
  end
end

def random_quote(server_id:, user: nil)
  quote = Quote.where(server_uid: server_id)

  if user
    quote = quote.where(quotee_uid: user.id)
  end

  quote.order("RANDOM()").first
end

def embed_for(event, quote)
  quotee_name = get_user_string(event: event, uid: quote.quotee_uid)

  quoter_name = get_user_string(event: event, uid: quote.quoter_uid)

  embed = Discordrb::Webhooks::Embed.new(
    color: "#3FB426",
    description: quote.quote,
    timestamp: quote.created_at
  )

  embed.author = Discordrb::Webhooks::EmbedAuthor.new(
    name: quotee_name,
    icon_url: get_user_avatar_url(event: event, uid: quote.quotee_uid)
  )

  embed.footer = Discordrb::Webhooks::EmbedFooter.new(
    text: "Quote ##{quote.id} by: #{quoter_name}",
    icon_url: get_user_avatar_url(event: event, uid: quote.quoter_uid)
  )

  embed
end

def get_user_string(event:, uid:)
  quote_user = event.server.member(uid)

  return quote_user.nick if quote_user&.nick.present?

  return "#{quote_user.username}##{quote_user.discriminator}" if quote_user&.username.present?

  discord_user = DiscordUser.find_by(uid: uid)
  return discord_user.name if discord_user&.name.present?

  "👻"
end

def get_user_avatar_url(event:, uid:)
  quote_user = event.server.member(uid)

  return quote_user.avatar_url if quote_user&.avatar_url.present?

  discord_user = DiscordUser.find_by(uid: uid)
  discriminator = discord_user&.discriminator.present? ? discord_user.discriminator.to_i % 5 : rand(0..4)

  "https://cdn.discordapp.com/embed/avatars/#{discriminator}.png"
end
