# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :type, null: false
      t.jsonb :data

      t.timestamps
    end
  end
end
