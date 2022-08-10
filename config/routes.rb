Rails.application.routes.draw do
  root :to => "tasks#index"
  devise_for :users
  resources :tasks do
    resources :comments, only: [:create, :destroy]
    get :assign, on: :member
    patch "assign" => "tasks#assign_update", on: :member
  end
  get "complete_tasks" => "tasks#complete_tasks"
  resources :users, :only => [:index, :show]
  get "mypage" => "users#mypage"
  get "mytask" => "users#mytask"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
