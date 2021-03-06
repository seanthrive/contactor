class Contact < ApplicationRecord
  belongs_to :user
  scope :oldest, -> (limit) { order("updated_at desc").first }
end
