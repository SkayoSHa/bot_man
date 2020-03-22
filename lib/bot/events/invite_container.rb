# frozen_string_literal: true

class InviteContainer < BaseEventContainer
  raw do |event|
    if event.type == :INVITE_CREATE
      handle_invite_create(event)
    end

    if event.type == :INVITE_DELETE
      handle_invite_delete(event)
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
    pp event.type
    pp event.data

    # Make sure we already have a log of that invite

    # Update it with the new information

    # :INVITE_DELETE
    # {"guild_id"=>"351488576325681162",
    #  "code"=>"HbHFwR",
    #  "channel_id"=>"464322466198716437"}
  end
end
