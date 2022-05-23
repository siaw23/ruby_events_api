class ScrapeEventsJob < ApplicationJob
  queue_as :default

  def perform
    events = Scraper::RubyConferences.scraped_events.map do |event_array|
      Scraper::Transformer.new(event_array).hashify
    end
    # TODO: Refactor
    events.each do |event|
      Event.create_with(
        start_date: Date.parse(DateSplitter.parse(event[:date]).join(',').split(',').first),
        end_date: Date.parse(DateSplitter.parse(event[:date]).join(',').split(',').last),
        venue: event[:location],
        twitter_handle: event[:twitter_handle]
      ).find_or_create_by(name: event[:name])
    end
  end
end
