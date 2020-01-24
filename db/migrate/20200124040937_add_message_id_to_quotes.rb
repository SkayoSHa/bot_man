# frozen_string_literal: true

class AddMessageIdToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :message_id, :bigint, null: true
  end
end
