# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Urls::Finder.call
  end

  def create
    Urls::Shortner.call(params[:url])
  rescue StandardError => e
    flash[:notice] = e.to_s
  ensure
    redirect_to urls_path
  end

  def show
    @url, @daily_clicks, @browsers_clicks, @platform_clicks = Urls::Displayer.call(params[:url])
  rescue ActiveRecord::RecordNotFound => e
    flash[:notice] = e.to_s

    redirect_to urls_path
  end

  def visit
    url = Url.find_by(short_url: params[:short_url])
    Urls::ClickLogger.call(params[:short_url], request)

    redirect_to url.original_url
  rescue ActiveRecord::RecordNotFound => e
    flash[:notice] = e.to_s

    redirect_to urls_path
  end
end
