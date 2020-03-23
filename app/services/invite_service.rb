# frozen_string_literal: true

class InviteService
  def self.ensure_invite(incoming_invite)
    # Save/update the user to the database
    new_invite = Invite.where(
      code: incoming_invite.code,
      server_uid: incoming_invite.server.id
    ).first_or_create

    new_invite.server_uid = incoming_invite.server.id
    new_invite.inviter_uid = incoming_invite.inviter.id
    new_invite.code = incoming_invite.code
    new_invite.channel_uid = incoming_invite.channel.id
    new_invite.uses = incoming_invite.uses
    new_invite.max_uses = incoming_invite.max_uses
    new_invite.active = true
    new_invite.temporary = incoming_invite.temporary
    new_invite.expires = Time.now + incoming_invite.max_age.seconds

    new_invite.save!
    new_invite
  end
end
