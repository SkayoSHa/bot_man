# frozen_string_literal: true

class RawWorker
  include Sidekiq::Worker

  def perform(payload)
    pp payload
    Event.create!(
      type: payload["type"],
      data: payload["data"]
    )
  end
end
