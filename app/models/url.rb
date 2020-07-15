class Url < ApplicationRecord
  self.primary_key = :shortened_body

  belongs_to :user
  has_many   :visits

  validates :body, :shortened_body, presence: true

  def visits_count(*args)
    Rails.cache.fetch([cache_key, __method__], expires_in: 1.hour) { visits.count }
  end
end
