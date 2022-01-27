# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name)  { |n| "NAME#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password         { 'password' }
    age              { 20 }
    gender           { 1 }
    # create時に自動でアカウントを有効化
    after(:create, &:confirm)
  end
end
