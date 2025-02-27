ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :role, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  permit_params do
    permitted = [:name, :role, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
  permit_params :name, :user_id

  filter :name
  filter :user_id
  filter :created_at
  filter :updated_at
  
  actions :all, except: []

  index do
    selectable_column


    id_column
    column :name
    column :role
    column :created_at
    actions
  end
end
