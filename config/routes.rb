Rails.application.routes.draw do
  devise_for :users
  root 'normalizer#index'

  scope :normalizer do
    post 'upload' => 'normalizer#upload'
  end
end
