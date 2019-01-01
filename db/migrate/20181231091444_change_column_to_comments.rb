class ChangeColumnToComments < ActiveRecord::Migration[5.2]

   rename_column :comments, :book_id, :impression_id
end
