class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :note
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
