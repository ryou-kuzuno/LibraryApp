class CreateImpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :impressions do |t|
      t.text :story
      t.text :impressions
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
