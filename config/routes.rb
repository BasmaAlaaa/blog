Rails.application.routes.draw do
  devise_for :users
  # Defines the route for the "blog_posts" resource
  resources :blog_posts do
    resources :comments, only: [:show , :create, :destroy]
  end
  
  root "blog_posts#index"
#get "up" => "rails/health#show", as: :rails_health_check
#patch "/blog_posts/:id" => "blog_posts#update", as: :update_blog_post
#delete "/blog_posts/:id" => "blog_posts#destroy" , as: :delete_blog_post
#get "/blog_posts/new" => "blog_posts#new", as: :new_blog_post
#get "/blog_posts/:id" => "blog_posts#show" , as: :blog_post # when you go to url /blog_posts/id it will call the show method in the blog_posts controller
#post "/blog_posts" => "blog_posts#create", as: :blog_posts
#get "/edit_blog_post/:id" => "blog_posts#edit", as: :edit_blog_post
end
