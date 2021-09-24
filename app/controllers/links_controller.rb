# frozen_string_literal: true

class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    shortener_link = Link.new(link_params)

    if shortener_link.save
      render json: {
        data: shortener_link,
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
