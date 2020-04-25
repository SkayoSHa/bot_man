# frozen_string_literal: true

class RemoveUniqueConstraintOnInviteDiscordUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :invite_discord_users, column: %i(invite_id discord_user_uid)
  end
end
