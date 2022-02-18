Rails.application.routes.draw do
  namespace :api do
      get "/ping", to: "ping#ping"
      get "/posts(/:tags(/:sortBy(/:direction)))", to: "posts#show"
  end
end
