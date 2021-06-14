class Api::UrlsController < Api::ApplicationController
  def index
    url = Urls::Finder.call

    render json: {data: UrlPresenter.for_collection.new(url) }
  end
end