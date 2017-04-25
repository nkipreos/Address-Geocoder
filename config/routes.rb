Rails.application.routes.draw do
  root 'normalizer#index'

  scope :normalizer do
    post 'upload' => 'normalizer#upload'
  end
end
