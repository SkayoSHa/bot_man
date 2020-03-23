# frozen_string_literal: true

class UserService
  def self.ensure_user(new_user)
    # Save/update the user to the database
    discord_user = DiscordUser.where(uid: new_user.id).first_or_create

    discord_user.name = new_user.name
    discord_user.discriminator = new_user.discriminator
    discord_user.avatar_url = new_user.avatar_url
    discord_user.bot_account = new_user.bot_account

    discord_user.save!
  end

  def self.ensure_user_oauth(new_user)
    # Save/update the user to the database
    discord_user = DiscordUser.where(uid: new_user.uid).first_or_create

    discord_user.name = new_user.info.name
    discord_user.discriminator = new_user.extra.raw_info.discriminator
    discord_user.avatar_url = new_user.info.image
    discord_user.bot_account = false

    discord_user.save!
  end
end
