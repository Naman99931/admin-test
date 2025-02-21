ActiveAdmin.register Post do
  controller do 
    before_action :authorize_admin

    def authorize_admin
      authorize! :manage, Post
    end
  end



  action_item :add_to_draft, only: :show do
    link_to "Add to Draft", add_draft_admin_post_path(post), method: :put if post.status == nil
  end

  action_item :publish_post, only: :show do
    link_to "Publish Post", publish_post_admin_post_path(post), method: :put if post.status == nil
  end

  batch_action :publish_post do |ids|
    batch_action_collection.find(ids).each do |post|
      post.update(status:"publish")
    end
    redirect_to collection_path, alert: "Published all these posts"
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :content, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:content, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :content, :user_id

  filter :content
  filter :user_id
  filter :created_at
  filter :updated_at

  filter :status[0, 1]
  
  actions :all, except: []

  index do
    selectable_column


    id_column
    column :content
    column :user do |record|
      record.user.name if record.user
    end
    column :created_at
    column :status
    actions
  end

  show do
    attributes_table_for(resource) do
      row :content
      row :user do |record|
        record.user.name if record.user
      end
      row :created_at
    end
    active_admin_comments_for(resource)
  end

  # controller do
  #   def find_user
  #     user = User.find(params[:user_id])
  #     user_name = user.name
  #   end
  # end

  
  member_action :add_draft, method: :put do
    resource.update(status:"draft")
    redirect_to resource_path, notice: "Post saved to draft"
  end

  member_action :publish_post, method: :put do
    resource.update(status:"publish")
    redirect_to resource_path, notice: "Post Published"
  end
end
