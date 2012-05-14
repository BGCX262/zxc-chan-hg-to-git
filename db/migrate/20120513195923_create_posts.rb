class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :content
      t.timestamps
    end
    add_column :posts, :post_id, :integer, :null => true
  end
end
