class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
