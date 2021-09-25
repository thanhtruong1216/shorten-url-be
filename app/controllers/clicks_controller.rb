class ClicksController < ApplicationController
  def show
    link = Link.find_by(slug: params[:slug])

    click = Click.new(link: link)
    click.save

    redirect_to link.url
  end
end
