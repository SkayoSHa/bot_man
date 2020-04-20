# frozen_string_literal: true

class CreateServers < ActiveRecord::Migration[6.0]
  def change
    create_table :servers do |t|
      t.bigint :uid, null: false
      t.string :name, null: false
      t.string :icon_id, null: false
      t.bigint :owner_uid, null: false
      t.bigint :region_id, null: false
      t.bigint :afk_channel_uid
      t.bigint :system_channel_uid
      t.boolean :large, null: false
      t.bigint :afk_timeout
      t.string :verification_level, null: false
      t.bigint :member_count, null: false
      t.datetime :creation_time, null: false

      t.timestamps
    end
  end
end
