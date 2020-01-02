# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :lockable,
         :recoverable, :rememberable, :validatable, :trackable
end
