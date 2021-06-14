class UrlPresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :short_url
  property :original_url
  property :clicks_count
  property :created_at
end
