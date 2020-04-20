# frozen_string_literal: true

class ServerService
  def self.ensure_server(new_server, bot_active = true)
    # Save/update the server to the database
    server = Server.where(uid: new_server.id).first_or_initialize

    server.name = new_server.name
    server.icon_id = new_server.icon_id
    server.owner_uid = new_server.owner.id
    server.region_id = new_server.region.id
    server.afk_channel_uid = new_server.afk_channel.id
    server.system_channel_uid = new_server.system_channel.id
    server.large = new_server.large
    server.afk_timeout = new_server.afk_timeout
    server.verification_level = new_server.verification_level
    server.member_count = new_server.member_count
    server.creation_time = new_server.creation_time
    server.bot_active = bot_active

    server.save!
    server
  end
end
