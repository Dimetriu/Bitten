class Visit < ApplicationRecord
  belongs_to :url, touch: true, foreign_key: :url_id
end
