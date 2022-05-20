module Scraper
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

  class RubyConferences
    def self.scraped_events
      [].tap do |collected_events|
        HTML.document.css("dl").children.select do |el|
          el.instance_of?(Nokogiri::XML::Element)
        end.each_slice(2) do |event|
          collected_events << event
        end
      end
    end
  end

  class Transformer
    attr_accessor :array
    def initialize(array = [])
      @array = array
    end

    def hashify
      {}.tap do |hash|
        hash[:name] = event_name
        hash[:url] = event_url
        hash[:date] = event_date
        hash[:location] = event_location
        hash[:twitter_handle] = event_twitter_handle || ""
      end
    end

    def event_name
      # `array` =>
      # => [#(Element:0x37dc {
      #   name = "dt",
      #   children = [
      #     #(Text "\n  \n  "),
      #     #(Element:0x39bc { name = "a", attributes = [ #(Attr:0x3b10 { name = "href", value = "https://railsconf.org" })], children = [ #(Text "Railsconf")] }),
      #     #(Text "\n  \n  \n  \n")]
      #   }),
      # #(Element:0x3f70 {
      #   name = "dd",
      #   children = [
      #     #(Text "\n  "),
      #     #(Element:0x4150 {
      #       name = "ul",
      #       children = [
      #         #(Text "\n    "),
      #         #(Element:0x4330 { name = "li", children = [ #(Text "\n      \n      \n      \n      \n\n      \n        May 17–19, 2022\n      \n    ")] }),
      #         #(Text "\n    "),
      #         #(Element:0x4600 { name = "li", children = [ #(Text "Portland, OR")] }),
      #         #(Text "\n    \n      "),
      #         #(Element:0x48d0 {
      #           name = "li",
      #           children = [
      #             #(Element:0x4a24 { name = "a", attributes = [ #(Attr:0x4b78 { name = "href", value = "https://twitter.com/railsconf" })], children = [ #(Text "@railsconf")] })]
      #           }),
      #         #(Text "\n    \n    \n  ")]
      #       }),
      #     #(Text "\n")]
      #   })]

      array.first.children[1].children[0].text
    end

    def event_url
      array.first.children[1].attribute("href").value
    end

    def event_date
      event_details_element[0].text.strip
    end

    def event_location
      event_details_element[1].text.strip
    end

    def event_twitter_handle
      event_details_element[2]&.children&.first&.text
    end

    private

    def event_details_element
      array.last.children[1].children.reject do |n|
        n.instance_of?(Nokogiri::XML::Text)
      end

      # `array.last` =>
      # [#(Element:0x24d74 { name = "li", children = [ #(Text "\n      \n      \n      \n      \n\n      \n        May 17–19, 2022\n      \n    ")] }),
      #  #(Element:0x25044 { name = "li", children = [ #(Text "Portland, OR")] }),
      #  #(Element:0x25314 {
      #    name = "li",
      #    children = [
      #      #(Element:0x25468 {
      #        name = "a",
      #        attributes = [ #(Attr:0x255bc { name = "href", value = "https://twitter.com/railsconf" })],
      #        children = [ #(Text "@railsconf")]
      #        })]
      #    })]
    end
  end

  class HTML
    RUBY_CONFERENCES_URL = "https://rubyconferences.org/".freeze

    def self.document
      require "open-uri"
      html = URI.parse(RUBY_CONFERENCES_URL).open
      Nokogiri::HTML(html.read)
    end
  end
end
