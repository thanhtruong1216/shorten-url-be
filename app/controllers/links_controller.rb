# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :authorize_request
  before_action :set_link, only: %i[show update destroy]

  def index
    links_with_ordered = current_user.links
                                     .order(created_at: :desc, updated_at: :desc)
                                     .page(params[:page]).per(page_size)

    links = links_with_ordered.map do |link|
      {
        id: link.id,
        shorten_url: link.shortener,
        title: link.title,
        slug: link.slug,
        url: link.url,
        total_clicks: link.clicks_count
      }
    end

    render json: {
      result: links,
      total: current_user.links.count
    }
  end

  def show
    render json: {
      result: {
        link: @link,
        short_link: @link.shortener,
        total_clicks: @link.clicks_count
      }
    }
  end

  def create
    shortener_link = current_user.links.build(link_params)

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
    if @link.update(link_params)
      render json: {
        result: @link,
        status: 200
      }
    else
      render json: {
        errors: @link.errors.full_messages,
        status: 422
      }
    end
  end

  def destroy
    @link.destroy

    render json: { message: 'Url destroyed', status: 200 }
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug, :title)
  end

  def set_link
    @link = current_user.links.find_by(id: params[:id])

    render json: { error: 'Link not found' } if @link.blank?

    @link
  end
end
