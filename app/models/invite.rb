# frozen_string_literal: true

# == Schema Information
#
# Table name: invites
#
#  id          :bigint           not null, primary key
#  active      :boolean          not null
#  channel_uid :string           not null
#  code        :string           not null
#  deleter_uid :bigint
#  expires     :datetime
#  inviter_uid :bigint           not null
#  max_uses    :integer
#  server_uid  :bigint           not null
#  temporary   :boolean          not null
#  uses        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Invite < ApplicationRecord
end
