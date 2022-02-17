class Api::PingController < ApplicationController
  def ping
    render status: 200, json: {success: "true"}
  end
end