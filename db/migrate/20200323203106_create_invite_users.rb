# frozen_string_literal: true

class CreateInviteUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :invite_users do |t|
      t.references :invite
      t.references :user

      t.timestamps
    end

    add_index :invite_users, %i(invite_id user_id), unique: true
  end
end
