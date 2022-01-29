ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :email, :password, :password_confirmation, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at, :name, :age, :gender, :role

  index do
    column :name
    column :email
    column :age
    column :gender
    column :role

    # 閲覧編集削除などのリンク表示
    actions
  end

  filter :email
  filter :age
  filter :gender
  filter :role

  show do
    attributes_table do
      row :name
      row :email
      row :age
      row :gender
      row :role
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :age
      f.input :gender
      f.input :role
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
