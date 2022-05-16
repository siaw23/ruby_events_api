class Event < ApplicationRecord
  validates :name, :start_date, :venue, presence: true
end
