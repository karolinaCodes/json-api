
class Api::PostsController < ApplicationController
  include HTTParty
  def posts 
    tags, sortBy, direction = params.values_at(:tags, :sortBy, :direction)
    valid_values = ['id', 'reads', 'likes', 'popularity', 'desc', 'asc'];
    parsed_tags = tags.split(',');

    #if !valid_values.include? sortBy 
     # return render status:400, json: {error: 'sortBy parameter is invalid'}
    #end

   # if !valid_values.include? direction
   #   return render status:400, json: {error: 'direction parameter is invalid'}
  #  end

    if parsed_tags.length == 1
      begin
        response= HTTParty.get("https://api.hatchways.io/assessment/blog/posts?tag=#{tags}")
        posts = JSON.parse(response.body)["posts"]
      rescue => error
        return render json: error
      else
        # if a sortBy value is passed, sort depending on the direction
        if sortBy

          if direction == "asc"
            posts= posts.sort_by{ |obj| obj[sortBy] }
          else
           posts=posts.sort_by{ |obj| obj[sortBy] }.reverse
          end

        return render json: posts
        end
      end

    end
    
    render status:400, json: {error: "yay"}
    #render json: {success: parsed_tags} 
  end 
end