Rails.application.configure do
  config.good_job = {
    active_record_parent_class: "ApplicationRecord",
    preserve_job_records: true,
    retry_on_unhandled_error: false,
    on_thread_error: ->(exception) { Raven.capture_exception(exception) },
    execution_mode: :async,
    queues: "*",
    max_threads: 5,
    poll_interval: 30,
    shutdown_timeout: 25,
    enable_cron: true,
    cron: {
      scrape_event: {
        cron: "* * * * *",
        class: "ScrapeEventsJob"
      }
    }
  }
end
