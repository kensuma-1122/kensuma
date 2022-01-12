# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_scope :user do
    root 'users/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  # devise_for :admins, controllers: {
  #   sessions: 'admins/sessions'
  # }

  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :managers, controllers: {
    sessions:      'managers/sessions',
    passwords:     'managers/passwords',
    confirmations: 'users/confirmations',
    registrations: 'managers/registrations'
  }

  namespace :users do
    resources :dash_boards, only: [:index]
    resources :articles, only: %i[index show]
    resource :profile, except: %i[create new]
    resource :businesses, except: %i[index destroy] do
      post 'stamp_images_add'
      delete 'stamp_images_delete'
    end
  end

  # 利用規約
  get 'use' => 'use#index'
end
