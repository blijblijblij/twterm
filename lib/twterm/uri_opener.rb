require 'launchy'
require 'singleton'
require 'twterm/event/open_uri'
require 'twterm/publisher'
require 'twterm/subscriber'
require 'twterm/event/notification/warning'

module Twterm
  class URIOpener
    include Publisher
    include Singleton
    include Subscriber

    def initialize
      subscribe(Event::OpenURI) { |e| open e.uri }
    end

    private

    def open(uri)
      Launchy.open(uri)
    rescue Launchy::CommandNotFoundError
      publish(Event::Notification::Warning.new('Browser not found'))
    end
  end
end
