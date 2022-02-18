class ErrorController < ActionController::API
  def not_found
    render status: 400, json: { error:"Page not found"}
  end
end