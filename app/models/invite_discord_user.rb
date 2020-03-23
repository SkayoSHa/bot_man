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
# Indexes
#
#  index_invite_discord_users_on_invite_id_and_discord_user_uid  (invite_id,discord_user_uid) UNIQUE
#
class InviteDiscordUser < ApplicationRecord
  belongs_to :invite
  belongs_to :discord_user, foreign_key: :discord_user_uid
end
