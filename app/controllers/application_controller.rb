class ApplicationController < ActionController::API

  def json body
    JSON.parse(body)
  end

  def return_parsed_response(url)
    begin
    response = HTTParty.get(url).parsed_response 
  rescue => error
    return render json: error
  else
    return response
  end
  end

end
