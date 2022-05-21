class RetireEventJob < ApplicationJob
  queue_as :default

  def perform
    Event.upcoming.each do |event|
      event.past! if event.end_date < Date.today
    end
  end
end
