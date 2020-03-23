# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def discord
    user = User.from_discord_omniauth(auth_hash)

    if user
      user.update_discord_data(auth_hash)
      UserService.ensure_user_oauth(auth_hash)

      redirect_to "#{FRONTEND_URL}?token=#{user.generate_jwt}"
    else
      # Do something else if they have no user...
      failure
    end
  end

  def failure
    redirect_to FRONTEND_URL
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
