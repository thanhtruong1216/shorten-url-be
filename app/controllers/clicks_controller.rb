class ClicksController < ApplicationController
  include ::ApplicationHelper

  def show
    link = Link.find_by(slug: params[:slug])

    click = Click.new(link: link)
    click.save

    if link.nil?
      redirect_to "#{frontend_base_url}/not_found"
    else
      redirect_to link.url
    end
  end
end
