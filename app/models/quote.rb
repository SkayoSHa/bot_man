# frozen_string_literal: true

# == Schema Information
#
# Table name: quotes
#
#  id         :bigint           not null, primary key
#  quote      :string
#  quotee_uid :bigint
#  quoter_uid :bigint
#  server_uid :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint
#
class Quote < ApplicationRecord
end
