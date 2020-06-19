# frozen_string_literal: true

class CreateReactionRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :reaction_roles do |t|
      t.bigint :message_id, null: false
      t.string :reaction, null: false
      t.bigint :role_id, null: false
      t.timestamps
    end
  end
end
