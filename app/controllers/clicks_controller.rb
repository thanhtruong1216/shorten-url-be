class ClicksController < ApplicationController
  def show
    link = Link.find_by(slug: params[:slug])

    click = Click.new(link: link)
    click.save

    not_found_url = Rails.env.production? ? 'https://shortenurlbe.herokuapp.com' : 'http://localhost:3001'
    redirect_to "#{not_found_url}/not_found" and return if link.nil?

    redirect_to link.url
  end
end
