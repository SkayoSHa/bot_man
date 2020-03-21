# frozen_string_literal: true

class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.bigint :server_uid, null: false
      t.bigint :inviter_uid, null: false
      t.string :code, null: false
      t.string :channel_uid, null: false
      t.integer :uses, null: false
      t.integer :max_uses
      t.boolean :active, null: false
      t.boolean :temporary, null: false
      t.datetime :expires

      t.timestamps
    end
  end
end
