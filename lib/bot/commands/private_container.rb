# frozen_string_literal: true

module PrivateContainer
  extend Discordrb::Commands::CommandContainer

  command :pm, description: "Responds in a private message" do |event|
    event.user.pm('Go away...')
  end
end
