class Api::PostsController < ApplicationController
  include HTTParty

  def posts 
    tags, sortBy, direction = params.values_at(:tags, :sortBy, :direction)
    valid_values = ["id", "reads", "likes", "popularity", "desc", "asc"];

    # error handling for params
    if !tags
      return render status:400, json: {error: "Tags parameter is required"}
    end

    if !valid_values.include? sortBy and sortBy
      return render status:400, json: {error: "sortBy parameter is invalid"}
    end
 
    if !valid_values.include? direction and direction
       return render status:400, json: {error: "direction parameter is invalid"}
    end

    parsed_tags = tags.split(",");

    # single tag
    if parsed_tags.length == 1
      posts = json(cached_result("https://api.hatchways.io/assessment/blog/posts?tag=#{tags}").body)["posts"]
      
      if sortBy
        return render json: {posts: sortPosts(posts, sortBy, direction)}
      else
        return render json: {posts: posts}
      end
    end

    # muliple tags
    begin
      threads = []
      parsed_responses = []
  
      parsed_tags.each {|tag|  threads << Thread.new { 
        parsed_responses << cached_result("https://api.hatchways.io/assessment/blog/posts?tag=#{tag}")
      }}

      threads.each(&:join)
      merged_arrays = parsed_responses[0]["posts"] + parsed_responses[1]["posts"]
    rescue => error
      return render json: error
    else
      if sortBy
        return render json: {posts: sortPosts(merged_arrays, sortBy, direction).uniq}
      else
        render json: {posts: merged_arrays.uniq}
      end
    end

  end 
end