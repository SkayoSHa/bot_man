# frozen_string_literal: true

class CreateTemporaryVoiceChannel < ActiveRecord::Migration[6.0]
  def change
    create_table :temporary_voice_channels do |t|
      t.bigint :server_uid, null: false
      t.bigint :creator_uid, null: false
      t.bigint :channel_uid, null: false
      t.boolean :is_jump_channel, null: false
      t.boolean :active, null: false

      t.timestamps
    end
  end
end
