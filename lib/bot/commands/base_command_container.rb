# frozen_string_literal: true

class BaseCommandContainer < ContainerWrapper
  extend Discordrb::Commands::CommandContainer

  # Overwrite command, so that we can record the
  # user that's triggering it in the database
  def self.command(name, attributes = {}, &block)
    super(name, attributes, &proc_wrapper(&block))
  end
end
