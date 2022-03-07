# frozen_string_literal: true

# 本番環境での確認の為、一時的に本番環境でもデータ作成されるように変更。本番運用時は元に戻す事。
# Admin.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
Admin.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# User
50.times do |i|
  user = User.new(
    email: "test_user#{i}@gmail.com", # sample: test_user1@gmail.com
    name: "テストuser#{i}",
    password: 'password'
  )

  user.skip_confirmation! # deviseの確認メールをスキップ
  user.save!
end
