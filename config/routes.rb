Rails.application.routes.draw do
  namespace :admin do
    resource :one_c7_connector, :only => [:new, :create]
  end
end
