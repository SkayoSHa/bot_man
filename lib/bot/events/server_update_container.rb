# frozen_string_literal: true

class ServerUpdateContainer < BaseEventContainer
  raw do |event|
    if event.type == :READY
      servers = event.bot.servers.values

      servers.each do |server|
        ServerService.ensure_server(server)
      end
    end

    if event.type == :GUILD_MEMBER_REMOVE
      if event.bot.profile.id.to_s == event.data["user"]["id"]
        server = Server.find_by(uid: event.data["guild_id"])

        server&.update!(
          bot_active: false
        )
      end
    end
  end

  server_create do |event|
    ServerService.ensure_server(event.server)
    Server.ensure_servers
  end

  server_update do |event|
    ServerService.ensure_server(event.server)
    Server.ensure_servers
  end

  member_join do |event|
    ServerService.ensure_server(event.server)
    Server.ensure_servers
  end

  member_leave do |event|
    ServerService.ensure_server(event.server)
    Server.ensure_servers
  end
end
