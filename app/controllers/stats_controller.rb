# frozen_string_literal: true

class StatsController < ApplicationController
  # before_action :authenticate_user!

  def index
    render json: {
      servers: Server.count
    }
  end
end
