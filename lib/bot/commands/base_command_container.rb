# frozen_string_literal: true

class BaseCommandContainer
  extend Discordrb::Commands::CommandContainer

  # Overwrite command, so that we can record the
  # user that's triggering it in the database
  def self.command(name, attributes = {}, &block)

    # Wrap the original proc
    wrapped_proc = Proc.new do |event|
      # Handle the event with whatever extra
      # we want to do
      handle_event(event)

      # Call the original proc passed into #command
      block.call(event)
    end

    # Call the original #command
    super(name, attributes = {}, &wrapped_proc)
  end

  def self.handle_event(event)
    UserService.update_db_from_user(event.user)
  end
end
