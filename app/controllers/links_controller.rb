# frozen_string_literal: true

class LinksController < ApplicationController
  def index
    links = []
    links_with_ordered = Link.all.order('created_at DESC')

    links_with_ordered.each do |link|
      data = { id: link.id, shorten_url: link.shortener, url: link.url, click_count: link.clicks.count }

      links << data
    end

    render json: { result: links }
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

  def update
    link = Link.find_by(id: params[:id])

    if link.update(link_params)
      render json: {
        result: link,
        status: 200
      }
    else
      render json: {
        error: link.errors.full_messages,
        status: 422
      }
    end
  end

  def destroy
    link = Link.find_by(id: params[:id])

    if link.destroy
      render json: {
        message: 'Url destroyed',
        status: 200
      }
    else
      render json: {
        message: 'Cannot destroy this url',
        status: 200
      }
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug, :user_id)
  end
end
