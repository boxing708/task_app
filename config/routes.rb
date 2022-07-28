Rails.application.routes.draw do
  devise_for :users
  root :to => "tasks#index"
  resources :tasks
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
