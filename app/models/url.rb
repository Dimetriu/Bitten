class Url < ApplicationRecord
  belongs_to :user
  has_many   :visits

  validates :body, :shortened_body, presence: true
end
