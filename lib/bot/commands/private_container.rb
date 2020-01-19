# frozen_string_literal: true

class PrivateContainer < BaseContainer
  command :pm, description: "Responds in a private message" do |event|
    event.user.pm('Go away...')
  end
end
