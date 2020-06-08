# frozen_string_literal: true

# == Schema Information
#
# Table name: servers
#
#  id                 :bigint           not null, primary key
#  afk_channel_uid    :bigint
#  afk_timeout        :bigint
#  bot_active         :boolean          not null
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
  scope :active, -> { where(bot_active: true) }

  def icon_url
    Discordrb::API.icon_url(uid, icon_id, "").chomp(".")
  end

  def timeline
    ActiveRecord::Base.connection.execute(<<~SQL).to_a
      select
        date_trunc('day', created_at)::DATE as day,
        count(*) as value
      from
        events
      where type = 'Events::MessageCreateEvent'
        and data->>'guild_id' = '#{uid}'
      group by 1
      order by 1
    SQL
  end
end
