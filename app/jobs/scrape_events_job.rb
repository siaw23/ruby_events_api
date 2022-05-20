class ScrapeEventsJob < ApplicationJob
  # include GoodJob::ActiveJobExtensions::Concurrency
  queue_as :default

  def perform(*args)
    puts "hello good_job"
  end
end
