module Urls
  class ClickLogger < ::BaseService
    attr_accessor :url, :browser

    def initialize(short_url, request)
      @url = Url.find_by(short_url: short_url)
      @browser = Browser.new(request.user_agent)

      raise ActiveRecord::RecordNotFound, 'Url not found' unless @url
    end

    def call
      @url.clicks.create!(
        browser: @browser.name,
        platform: @browser.platform
      )
    end
  end
end
