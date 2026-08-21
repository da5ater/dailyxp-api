Rails.application.routes.draw do
  get "/health", to: "health#show"
  get "/api/v1/protocol", to: "health#protocol"
end
