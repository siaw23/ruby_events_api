class Event < ApplicationRecord
  validates :name, :start_date, :venue, presence: true

  enum status: {
    upcoming: 0,
    past: 1
  }

  alias_attribute :location, :venue
end
