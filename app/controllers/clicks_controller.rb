class ClicksController < ApplicationController
  include ::ApplicationHelper

  def show
    link = Link.find_by(slug: params[:slug])

    if link.nil?
      redirect_to "#{frontend_base_url}/not_found"
    else
      link.clicks.create

      redirect_to link.url
    end
  end
end
