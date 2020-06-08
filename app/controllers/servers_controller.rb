# frozen_string_literal: true

class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_server, only: [:timeline]

  def index
    @servers = Server.active
  end

  def timeline
    @timeline = @server.timeline
  end

  private

  def set_server
    @server = Server.find_by(uid: server_uid)
  end

  def server_uid
    params.require(:server_id)
  end
end
