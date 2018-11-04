class Url < ApplicationRecord
  belongs_to :user

  validates :body, :shortened_body, presence: true
end
