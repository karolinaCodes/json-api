class Api::PostsController < ApplicationController
  include HTTParty
  def show 
    tags, sortBy, direction = params.values_at(:tags, :sortBy, :direction)
    valid_values = ['id', 'reads', 'likes', 'popularity', 'desc', 'asc'];
    parsed_tags = tags.split(',');

    if !valid_values.include? sortBy and sortBy
      return render status:400, json: {error: 'sortBy parameter is invalid'}
     end
 
     if !valid_values.include? direction and direction
       return render status:400, json: {error: 'direction parameter is invalid'}
     end

    if parsed_tags.length == 1
      begin
        response= HTTParty.get("https://api.hatchways.io/assessment/blog/posts?tag=#{tags}")
        posts = JSON.parse(response.body)["posts"]
      rescue => error
        return render json: error
      else
        # if a sortBy value is passed, sort depending on the direction
        if sortBy
          if direction == "desc"
           posts=posts.sort_by{ |obj| obj[sortBy] }.reverse
          else
           posts= posts.sort_by{ |obj| obj[sortBy] }
          end

          return render json: {posts: posts}

        else
          return render json: {posts: posts}

        end
      end

    end

    def return_parsed_response(url)
      HTTParty.get(url).parsed_response 
    end
    
    threads = []
    
    parsed_responses = []

    parsed_tags.each {|tag|  threads << Thread.new { 
      parsed_responses << return_parsed_response("https://api.hatchways.io/assessment/blog/posts?tag=#{tag}")
    }}

    # wait for threads to finish execution before continuing
    threads.each(&:join)

    merged_arrays = parsed_responses[0]["posts"] + parsed_responses[1]["posts"]
    
    
    render json: merged_arrays.uniq!
    #render json: {success: parsed_tags} 
  end 
end