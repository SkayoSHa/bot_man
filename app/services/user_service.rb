# frozen_string_literal: true

class UserService
  def self.update_db_from_user(new_user)
    # Save/update the user to the database
    discord_user = DiscordUser.where(uid: new_user.id).first_or_create do |user|
      user.name = new_user.name
      user.discriminator = new_user.discriminator
      user.avatar_url = new_user.avatar_url
      user.bot_account = new_user.bot_account
    end

    discord_user.save!
  end
end
