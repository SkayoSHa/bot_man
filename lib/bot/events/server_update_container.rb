# frozen_string_literal: true

class ServerUpdateContainer < BaseEventContainer
  raw do |event|
    if event.type == :READY
      servers = event.bot.servers.values

      servers.each do |server|
        ServerService.ensure_server(server)
      end
    end
  end

  server_create do |event|
    ServerService.ensure_server(event.server)
  end

  member_join do |event|
    ServerService.ensure_server(event.server)
  end

  member_update do |event|
    ServerService.ensure_server(event.server)
  end
end
