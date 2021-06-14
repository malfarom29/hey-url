module Urls
  class Shortner < BaseService
    attr_accessor :short_url

    URL_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

    def initialize(url)
      @original_url = url[:original_url]
    end

    def call
      validate!
      generate_short_url
      Url.create!(
        original_url: @original_url,
        short_url: @short_url
      )
    end

    private

    def validate!
      original_url = scheme? ? @original_url : "http://#{@original_url}"

      return if original_url.match?(URL_REGEXP)

      raise StandardError, 'Invalid Url'
    end

    def generate_short_url
      @short_url = ('A'..'Z').to_a.sample(5).join

      generate_short_url if Url.find_by(short_url: @short_url)
    end

    def scheme?
      @original_url.include?('https') || @original_url.include?('http')
    end
  end
end
