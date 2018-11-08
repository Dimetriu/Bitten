class VisitsCounterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.cache.fetch([cache_key, __method__], expires_in: 1.hour) { visits.count }
  end
end
