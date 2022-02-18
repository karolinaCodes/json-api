Rails.application.routes.draw do
  
  namespace :api, defaults: { format: :json } do
      get "/ping", to: "ping#ping"
      get "/posts(/:tags(/:sortBy(/:direction)))", to: "posts#posts"
  end
  
  get "*unmatched_route", to: "error#not_found"
end
