# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  discord_uid            :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default("0"), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default("0"), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :lockable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[discord]

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  has_many :invite_users
  has_many :invites, through: :invite_users

  def self.from_discord_omniauth(auth)
    # Check first for a uid match
    user = where(discord_uid: auth.uid).first
    return user if user

    # Then for a verfied email match
    if auth.extra.raw_info.verified
      where(email: auth.info.email).first
    end
  end

  def update_discord_data(discord_auth)
    update(
      email: discord_auth.info.email,
      discord_uid: discord_auth.uid
    )
  end

  def generate_jwt
    JWT.encode({
                 id: id,
                 exp: 7.days.from_now.to_i
               },
               Rails.application.secrets.secret_key_base)
  end
end
