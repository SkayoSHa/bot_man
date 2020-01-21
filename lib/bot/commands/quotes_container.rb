# frozen_string_literal: true

class QuotesContainer < BaseCommandContainer
  command :addquote, min_args: 2, description: "Records a new quote", usage: 'addquote @<user> [the quote to add]' do |event, target_user_string, *quote|
    return "Please tag someone to quote" unless target_user_string
    return "Please add a quote" unless quote

    quote = quote.join(" ")

    target_user_id = target_user_string.delete("^0-9")
    target_user = event.server.member(target_user_id)
    return "Please tag someone to quote" unless target_user

    # Make sure that the target user is in the DB
    UserService.update_db_from_user(target_user)

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

  command :quote, aliases: [:quotes], min_args: 0, max_args: 1, description: "Replays a quote", usage: 'quote (@<user>|<id>)' do |event, target|
    # Return a random one, if target is nil
    quote = random_quote if target.nil?

    unless quote
      key = target.delete("^0-9")

      target_user = event.server.member(key)

      # There was a user supplied
      if target_user
        quote =  random_quote(user: target_user)
      else

      end

      quote = Quote.find_by(server_uid: event.server.id, id: key)
    end

    return "No quote found." unless quote

    quoter = event.server.member(quote.quoter_uid)
    quoter_name = quoter.nick || "#{quoter.username}##{quoter.discriminator}"

    quotee = event.server.member(quote.quotee_uid)
    quotee_name = quotee.nick || "#{quotee.username}##{quotee.discriminator}"

    embed = Discordrb::Webhooks::Embed.new(
      color: "#3FB426",
      description: quote.quote,
      timestamp: quote.created_at
    )
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: quotee_name, icon_url: quotee.avatar_url)
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Quoted by: #{quoter_name}", icon_url: quoter.avatar_url)

    event.bot.send_message(event.channel, "", false, embed)
    nil
  end

  command :removequote, min_args: 1, max_args: 1, description: "Removes a quote", usage: 'removequote [the quote ID to remove]' do |event, quote_id|
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
end

def random_quote(user: nil)
  quote = Quote

  if user
    quote = quote.where(quotee_uid: user.id)
  end

  quote.order("RANDOM()").first
end
