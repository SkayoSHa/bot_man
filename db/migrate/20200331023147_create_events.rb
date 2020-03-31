# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.bigint :server_uid, null: false
      t.string :type
      t.jsonb :data

      t.timestamps
    end
  end
end
