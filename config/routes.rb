Rails.application.routes.draw do
  root :to => "tasks#index"
  devise_for :users
  resources :tasks
  resources :users, :only => [:index, :show]
  get "mypage" => "users#mypage"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
