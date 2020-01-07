# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :lockable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def generate_jwt
    JWT.encode({
        id: id,
        exp: 7.days.from_now.to_i
      },
      Rails.application.secrets.secret_key_base
    )
  end
end
