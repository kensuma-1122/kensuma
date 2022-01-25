# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # admin関連=========================================================
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # devise_for :admins, controllers: {
  #   sessions: 'admins/sessions'
  # }

  # =================================================================

  # user関連==========================================================
  devise_scope :user do
    root 'users/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  namespace :users do
    resources :dash_boards, only: [:index]
    resources :articles, only: %i[index show]
    resource :profile, except: %i[create new]
    resource :business, except: %i[index destroy] do
      delete 'update_images'
    end
    get 'general_users', to: 'general_users#index'
    get 'general_users/:id', to: 'general_users#show'
    get 'general_users', to: 'general_users#new'
    post 'general_users', to: 'general_users#edit'
    patch 'general_users/:id', to: 'general_users#update'
    delete 'general_users/:id', to: 'general_users#destroy'
  end
  # =================================================================

  # manager関連=======================================================
  # devise_for :managers, controllers: {
  #   sessions:      'managers/sessions',
  #   passwords:     'managers/passwords',
  #   confirmations: 'users/confirmations',
  #   registrations: 'managers/registrations'
  # }

  # =================================================================

  # 共通==============================================================
  # 利用規約
  get 'use' => 'use#index'
  # =================================================================
end
