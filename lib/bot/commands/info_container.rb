# frozen_string_literal: true

class InfoContainer < BaseCommandContainer
  command :test, description: "Responds with various things for testing...", help_available: false do |event|
    break unless event.user.id == 147930850091073536

    binding.pry
    "TEST"
  end

  command :user, description: "Responds with your name" do |event|
    event.user.name
  end

  command :invite, description: "Responds with the bot's invite URL", chain_usable: false do |event|
    event.bot.invite_url
  end

  command :random, min_args: 0, max_args: 2, description: 'Generates a random number between 0 and 1, 0 and max or min and max.', usage: 'random [min/max] [max]' do |_event, min, max|
    if max
      rand(min.to_i..max.to_i)
    elsif min
      rand(0..min.to_i)
    else
      rand
    end
  end
end
