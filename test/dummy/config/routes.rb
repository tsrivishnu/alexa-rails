Rails.application.routes.draw do
  mount Alexa::Engine => "/alexa"
end
