# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :authorize_request

  def index
    links = []
    links_with_ordered = Link.all.order('created_at DESC')

    links_with_ordered.each do |link|
      data = {
        id: link.id,
        shorten_url: link.shortener,
        title: link.title,
        slug: link.slug,
        url: link.url,
        total_clicks: link.clicks_count
      }

      links << data
    end

    link_with_pagination = Kaminari.paginate_array(links).page(params[:page]).per(page_size)

    render json: {
      result: link_with_pagination,
      total: links.count
    }
  end

  def show
    link = Link.find_by(id: params[:id])

    render json: {
      result: {
        link: link,
        short_link: link.shortener,
        total_clicks: link.clicks_count
      }
    }
  end

  def create
    shortener_link = Link.new(link_params)
    shortener_link.user = current_user

    if shortener_link.save
      render json: {
        result: shortener_link.shortener,
        status: 200
      }
    else
      render json: {
        errors: shortener_link.errors.full_messages,
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
        errors: link.errors.full_messages,
        status: 422
      }
    end
  end

  def destroy
    link = Link.find_by(id: params[:id])
    link.destroy

    render json: { message: 'Url destroyed', status: 200 }
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug, :title)
  end
end
