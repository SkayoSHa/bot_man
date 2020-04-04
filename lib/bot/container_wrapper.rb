# frozen_string_literal: true

class ContainerWrapper
  def self.proc_wrapper(&block)
    # Wrap the original proc
    proc do |event, *args|
      # Handle the event with whatever extra
      # we want to do
      handle_event(event, args)

      # Call the original proc passed into #command
      block.call(event, *args)
    end
  end

  def self.handle_event(_event, _args)
    # UserService.ensure_user(event.user)
  end

  def self.get_server_by_guild_id(guild_id, bot)
    bot.servers.values.detect { |server| server.id.to_s == guild_id.to_s }
  end
end
