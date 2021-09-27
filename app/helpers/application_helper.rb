module ApplicationHelper
  def frontend_base_url
    Rails.env.production? ? 'https://blooming-badlands-76554.herokuapp.com' : 'http://localhost:3001'
  end

  def backend_base_url
    Rails.env.production? ? 'https://shortenurlbe.herokuapp.com' : 'http://localhost:3000'
  end
end
