# frozen_string_literal: true

# == Schema Information
#
# Table name: invite_discord_users
#
#  id               :bigint           not null, primary key
#  discord_user_uid :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  invite_id        :bigint
#
class InviteDiscordUser < ApplicationRecord
  belongs_to :invite
  belongs_to :discord_user, foreign_key: :discord_user_uid
end
