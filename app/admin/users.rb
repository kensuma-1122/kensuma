ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :password, :password_confirmation, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at, :name, :age, :gender, :role
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at, :name, :age, :gender]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :role
    column :email
    column :name
    column :age
    column :gender
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions

    # # （例）belongs_to でつながっている parent_model のリンク付きの項目
    # column :parent_model do |model_name|
    #   link_to model_name.parent_model.title, admin_parent_model_path(model_name.parent_model)
    # end
  end

  filter :role
  filter :email
  filter :name
  filter :age
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :role
      f.input :email
      f.input :name
      f.input :age
      f.input :gender
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
