# frozen_string_literal: true

require "rails_helper"
require "#{Rails.root}/lib/bot/commands/base_command_container.rb"
require "#{Rails.root}/lib/bot/commands/mass_move_container.rb"

RSpec.describe MassMoveContainer do
  let(:channels) do
    [
      double(name: "AdminChat"),
      double(name: "FounderChat"),
      double(name: "The Lounge"),
      double(name: "➥ Create Room!"),
      double(name: "Destiny 2"),
      double(name: "D2 - Trails - Team 1"),
      double(name: "D2 - Trails - Team 2"),
      double(name: "Rocket League"),
      double(name: "Overwatch"),
      double(name: "Rainbow Six Siege"),
      double(name: "Civilization / Age"),
      double(name: "Rust"),
      double(name: "Bot Development"),
      double(name: "~COUNT VON COUNT"),
      double(name: "~BERT"),
      double(name: "-- AFK --"),
      double(name: "DevVoice")
    ]
  end

  it "calculates the closest_channel for 'lounge'" do
    expect_closest_channel("lounge", "The Lounge")
    expect_closest_channel("Lounge", "The Lounge")

    expect_closest_channel("destiny", "Destiny 2")
    expect_closest_channel("Destiny", "Destiny 2")

    expect_closest_channel("create", "➥ Create Room!")
    expect_closest_channel("development", "Bot Development")

    # Direct substring tests
    expect_closest_channel("Age", "Civilization / Age")
    expect_closest_channel("rocket", "Rocket League")
  end

  def expect_closest_channel(source, expectation)
    closest = MassMoveContainer.closest_channel(source, channels)
    expect(closest.name).to eq(expectation)
  end
end
