# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    render "dashboards/show", formats: :html
  end
end
