# frozen_string_literal: true

# == Schema Information
#
# Table name: temporary_voice_channels
#
#  id              :bigint           not null, primary key
#  active          :boolean          not null
#  channel_uid     :string           not null
#  creator_uid     :bigint           not null
#  is_jump_channel :boolean          not null
#  server_uid      :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class TemporaryVoiceChannel < ApplicationRecord
end
