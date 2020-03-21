# frozen_string_literal: true

# == Schema Information
#
# Table name: discord_users
#
#  avatar_url    :string
#  bot_account   :boolean
#  discriminator :string
#  name          :string
#  uid           :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class DiscordUser < ApplicationRecord
end
