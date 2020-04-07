# frozen_string_literal: true

class RawWorker
  include Sidekiq::Worker

  def perform(type, data)
    pp "THIS IS A TEST #{type}"
    pp data
  end
end
