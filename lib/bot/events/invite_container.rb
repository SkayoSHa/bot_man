# frozen_string_literal: true

class InviteContainer < BaseEventContainer
  server_create do |event|
    log_all_invites(event.server)
  end

  raw do |event|
    if event.type == :INVITE_CREATE
      handle_invite_create(event)
    end

    if event.type == :INVITE_UPDATE
      pp :INVITE_UPDATE
      pp event
    end

    if event.type == :INVITE_DELETE
      handle_invite_delete(event)
    end

    if event.type == :READY
      servers = event.bot.servers.values

      servers.each do |server|
        log_all_invites(server)
      end
    end
  end

  def self.handle_invite_create(event)
    # Save the new invite that was just created
    data = event.data.symbolize_keys

    Invite.create!(
      server_uid: data[:guild_id],
      inviter_uid: data[:inviter]["id"],
      code: data[:code],
      channel_uid: data[:channel_id],
      uses: data[:uses],
      max_uses: data[:max_uses],
      active: true,
      temporary: data[:temporary],
      expires: Time.now + data[:max_age].seconds,
    )

    # :INVITE_CREATE
    # {"uses"=>0,
    #  "temporary"=>true,
    #  "max_uses"=>1,
    #  "max_age"=>3600,
    #  "inviter"=>
    #   {"username"=>"Dracco",
    #    "id"=>"147930850091073536",
    #    "discriminator"=>"0001",
    #    "avatar"=>"db040d6c9c49f67f87c162b88c52ae03"},
    #  "guild_id"=>"351488576325681162",
    #  "created_at"=>"2020-03-21T22:50:32.853014+00:00",
    #  "code"=>"HbHFwR",
    #  "channel_id"=>"464322466198716437"}
  end

  def self.handle_invite_delete(event)
    data = event.data.symbolize_keys
    guild_id = data[:guild_id]

    # Get the user the deleted the invite
    # based on the server's audit logs
    server = get_server_by_guild_id(guild_id, event.bot)

    # TODO: Maybe make this a little more error-hardened
    audit_log = server.audit_logs.latest

    # Check to see if that log is for the invite delete
    if audit_log.action == :invite_delete
      user = audit_log.user
    end

    invite = Invite.find_by(
      server_uid: data[:guild_id],
      code: data[:code],
      channel_uid: data[:channel_id],
    )

    # Make sure we already have a log of that invite
    # Potentially add record in the future based
    # on audit logs if one doesn't exist
    # Set the invite to inactive
    invite&.update!(
      active: false,
      deleter_uid: user&.id
    )

    # :INVITE_DELETE
    # {"guild_id"=>"351488576325681162",
    #  "code"=>"HbHFwR",
    #  "channel_id"=>"464322466198716437"}
  end

  def self.log_all_invites(server)
    invites = server.invites

    invites.each do |incoming_invite|
      new_invite = Invite.where(
        code: incoming_invite.code,
        server_uid: incoming_invite.server.id
      ).first_or_create do |invite|
        invite.server_uid = incoming_invite.server.id
        invite.inviter_uid = incoming_invite.inviter.id
        invite.code = incoming_invite.code
        invite.channel_uid = incoming_invite.channel.id
        invite.uses = incoming_invite.uses
        invite.max_uses = incoming_invite.max_uses
        invite.active = true
        invite.temporary = incoming_invite.temporary
        invite.expires = Time.now + incoming_invite.max_age.seconds
      end

      new_invite.save!
    end
  end
end
