# Ruby Events API

This is not the traditional CRUD API you're used to. What this repo does is scrape items from sites like [Ruby Conferences](https://rubyconferences.org/) and turns the data into JSON. Built with free time, it doesn't make sense hosting this on Heroku for $14/month. I'm currently looking for a free host.

There are only two background jobs that do all the work, one to scrape content and the other to for past events and remove them:

The `ScrapeEventsJob` scrapes for data. The `RetireEventJob` checks and removes past events from the `/events` endpoint.

![Ruby Events API](https://raw.githubusercontent.com/siaw23/ruby_events_api/main/events-api.png)
