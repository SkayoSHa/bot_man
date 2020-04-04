# frozen_string_literal: true

class UserUpdateContainer < BaseEventContainer
  raw do |event|
    if event.type == :READY
      servers = event.bot.servers.values

      servers.each do |server|
        log_users(server)
      end
    end
  end

  server_create do |event|
    log_users(event.server)
  end

  member_join do |event|
    UserService.ensure_user(event.user)
  end

  member_update do |event|
    UserService.ensure_user(event.user)
  end

  def self.log_users(server)
    server.users.each do |user|
      UserService.ensure_user(user)
    end
  end
end
