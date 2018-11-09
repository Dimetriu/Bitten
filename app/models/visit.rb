class Visit < ApplicationRecord
  belongs_to :url, touch: true, foreign_key: :shortened_body
end
