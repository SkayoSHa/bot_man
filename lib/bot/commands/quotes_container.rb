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
    return format_quote(random_quote) if target.nil?

    key = target.delete("^0-9")

    target_user = event.server.member(key)

    # There was a user supplied
    if target_user
      return format_quote(random_quote(user: target_user))
    end

    quote = Quote.find_by_id(key)
    return format_quote(quote)
  end
end

def random_quote(user: nil)
  quote = Quote

  if user
    quote = quote.where(quotee_uid: user.id)
  end

  quote.order("RANDOM()").first
end

def format_quote(quote)
  return "No quote found." unless quote
  quote.quote
end
