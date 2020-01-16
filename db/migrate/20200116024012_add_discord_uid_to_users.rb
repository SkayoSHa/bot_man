# frozen_string_literal: true

class AddDiscordUidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :discord_uid, :string
  end
end
