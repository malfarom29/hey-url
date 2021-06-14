module Urls
  class Finder < BaseService
    def call
      Url.order(created_at: :desc).limit(10)
    end
  end
end
