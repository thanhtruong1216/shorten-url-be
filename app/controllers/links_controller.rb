# frozen_string_literal: true

class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    shorten_urls = []
    links_with_ordered = Link.all.order('created_at DESC')

    links_with_ordered.each do |link|
      data = { id: link.id, shorten_url: link.shortener }

      shorten_urls << data
    end

    render json: { result: shorten_urls }
  end

  def create
    shortener_link = Link.new(link_params)

    if shortener_link.save
      render json: {
        result: shortener_link.shortener,
        status: 200
      }
    else
      render json: {
        error: shortener_link.errors.full_messages,
        status: 422
      }
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
