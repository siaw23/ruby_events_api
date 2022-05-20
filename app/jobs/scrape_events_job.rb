class ScrapeEventsJob < ApplicationJob
  queue_as :default

  def perform
    events = Scraper::RubyConferences.scraped_events.map do |ary|
      Scraper::Transformer.new(ary).hashify
    end

    events.each do |event|
      Event.find_or_create_by(
        name: event[:name],
        start_date: DateTime.new(2001, 2, 3),
        end_date: DateTime.new(2002, 2, 3),
        venue: event[:location],
        twitter_handle: event[:twitter_handle]
      )
    end
  end
end

# Scraper::RubyConferences.scraped_events.map do |ary|
#   Scraper::Transformer.new(ary).hashify
# end

# # [
# #   { name: 'Railsconf', url: 'https://railsconf.org', date: 'May 17–19, 2022', location: 'Portland, OR',
# #     twitter_handle: '@railsconf' },
# #   { name: 'Brighton Ruby', url: 'https://brightonruby.com/', date: 'June 30, 2022', location: 'Brighton, England',
# #     twitter_handle: '' },
# #   { name: 'Rails Camp West', url: 'https://west.railscamp.us/2022', date: 'August 30–September 2, 2022',
# #     location: 'Diablo Lake, WA', twitter_handle: '@railscamp_usa' },
# #   { name: 'Euruko', url: 'https://2022.euruko.org', date: 'October 13–14, 2022', location: 'Helsinki, Finland',
# #     twitter_handle: '@euruko' }
# # ]
