ActiveAdmin.register News do
  permit_params :title, :content, :delivered_at, :status

  controller do
    def find_resource
      scoped_collection.where(uuid: params[:id]).first!
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :delivered_at
    column :status
    actions
  end

  filter :title
  filter :content
  filter :delivered_at
  filter :status

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :delivered_at, as: :datetime_picker
      f.input :status
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :content, :delivered_at, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content, :delivered_at, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
