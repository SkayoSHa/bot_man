# frozen_string_literal: true

# == Schema Information
#
# Table name: servers
#
#  id                 :bigint           not null, primary key
#  afk_channel_uid    :bigint
#  afk_timeout        :bigint
#  creation_time      :datetime         not null
#  large              :boolean          not null
#  member_count       :bigint           not null
#  name               :string           not null
#  owner_uid          :bigint           not null
#  system_channel_uid :bigint
#  uid                :bigint           not null
#  verification_level :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  icon_id            :string           not null
#  region_id          :string           not null
#
class Server < ApplicationRecord
end
