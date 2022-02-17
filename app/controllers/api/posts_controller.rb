
class Api::PostsController < ApplicationController
  include HTTParty
  def posts 
    tags, sortBy, direction = params.values_at(:tags, :sortBy, :direction)
    valid_values = ['id', 'reads', 'likes', 'popularity', 'desc', 'asc'];
    parsed_tags = tags.split(',');




    
    render status:400, json: {error: "yay"}
    #render json: {success: parsed_tags} 
  end 
end