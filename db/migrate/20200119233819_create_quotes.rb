# frozen_string_literal: true

class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.bigint :server_uid
      t.bigint :quoter_uid
      t.bigint :quotee_uid
      t.string :quote

      t.timestamps
    end
  end
end
