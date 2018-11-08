class Visit < ApplicationRecord
  belongs_to :url, touch: true
end
