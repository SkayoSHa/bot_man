# frozen_string_literal: true

class ServersController < ApplicationController
  # before_action :authenticate_user!

  def index
    @servers = Server.active
  end
end
