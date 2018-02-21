Alexa::Engine.routes.draw do
  resources :intent_handlers, only: [:create]
end
