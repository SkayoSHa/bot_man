# frozen_string_literal: true

# == Schema Information
#
# Table name: invite_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invite_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_invite_users_on_invite_id              (invite_id)
#  index_invite_users_on_invite_id_and_user_id  (invite_id,user_id) UNIQUE
#  index_invite_users_on_user_id                (user_id)
#
class InviteUser < ApplicationRecord
  belongs_to :invite
  belongs_to :user
end
