class ApplicationController < ActionController::API

  def json body
    JSON.parse(body)
  end

  def cached_result url
    Rails.cache.fetch("response", expires_in: 1.day) do
      HTTParty.get(url)
    end
  end

  def return_parsed_response(url)
    begin
      response = cached_result(url).parsed_response 
    rescue => error
     return render json: error
    else
      return response
    end
  end
  
end
