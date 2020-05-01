# frozen_string_literal: true

class SetCommandContainer < BaseCommandContainer
  extend Discordrb::EventContainer

  command(
    :set,
    min_args: 1,
    description: "Updates a bot/server setting",
    usage: "set [setting] [additional options]",
    help_available: true
  ) do |event, setting, *options|
    return "Please supply a setting" unless setting

    # Make sure that the user is an admin
    return "Permission denied." unless event.user.permission?(:administrator)

    response = ""

    case setting
    when "region"
      response = set_server_region(event, options)
    else
      return "Invalid setting."
    end

    return response
  end

  def self.set_server_region(event, options)
    available_regions = event.server.available_voice_regions

    # If no options, display server regions
    if options.any?
      new_region = available_regions.detect { |region| region.id == options.first }

      if new_region
        # If they provided a vaild region
        event.server.region = options.first
        "Server moved to `#{event.server.region.name}`"
      else
        # If they provided a invaild region
        "Invalid server region."
      end
    else
      # If they didn't provide a region
      <<~STR
        Current region:
        `#{event.server.region.id}`

        Available regions:
        `#{available_regions.map(&:id).join('`, `')}`
      STR
    end
  end
end
