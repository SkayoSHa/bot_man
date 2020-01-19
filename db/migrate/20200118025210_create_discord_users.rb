# frozen_string_literal: true

class CreateDiscordUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :discord_users, id: false do |t|
      t.bigint :uid, primary_key: true
      t.string :name
      t.string :discriminator
      t.string :avatar_url
      t.boolean :bot_account

      t.timestamps
    end
  end
end
