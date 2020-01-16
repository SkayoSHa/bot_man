# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :lockable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[discord]

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

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
      Rails.application.secrets.secret_key_base
    )
  end
end
