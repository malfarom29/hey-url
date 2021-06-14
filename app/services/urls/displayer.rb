module Urls
  class Displayer < ::BaseService
    attr_accessor :url

    def initialize(short_url)
      @url = Url.find_by(short_url: short_url)

      raise ActiveRecord::RecordNotFound, 'Url not found' unless @url
    end

    def call
      [@url, daily_clicks, browsers, platforms]
    end

    private

    def clicks
      @url.clicks
    end

    def daily_clicks
      clicks.group('created_at::date')
            .where(
              <<~SQL
                created_at BETWEEN date_trunc('month', CURRENT_DATE)  AND (date_trunc('month', CURRENT_DATE) + INTERVAL '1 month - 1 second')
              SQL
            )
            .pluck('created_at::date, count(*) total_clicks')
            .map { |date, value| [date.strftime('%m/%d'), value] }
    end

    def browsers
      clicks.group('browser').count.map { |k, v| [k, v] }
    end

    def platforms
      clicks.group('platform').count.map { |k, v| [k, v] }
    end
  end
end
