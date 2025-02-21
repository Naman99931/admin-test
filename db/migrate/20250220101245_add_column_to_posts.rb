class AddColumnToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :status, :integer, default: nil
  end
end
