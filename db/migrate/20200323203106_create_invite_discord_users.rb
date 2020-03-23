# frozen_string_literal: true

class CreateInviteDiscordUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :invite_discord_users do |t|
      t.bigint :invite_id
      t.bigint :discord_user_uid

      t.timestamps
    end

    add_index :invite_discord_users, %i(invite_id discord_user_uid), unique: true
  end
end
