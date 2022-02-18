class ApplicationController < ActionController::API

  def json body
    JSON.parse(body)
  end

  # cache result of api call and return cached result
  def cached_result url
    begin
     Rails.cache.fetch("response", expires_in: 1.day) do
       HTTParty.get(url)
     end
     rescue => error
       return render json: error
     end
  end

  def sortPosts posts, sortBy, direction
    if direction == "desc"
      posts.sort_by{ |obj| obj[sortBy] }.reverse
    else
      posts.sort_by{ |obj| obj[sortBy] }
    end
  end
  
end
