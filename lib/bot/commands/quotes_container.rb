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
end
