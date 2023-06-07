class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  # Sneak: add_index...
  # Camel: AddIndex...
  def change
    add_index :users, :email, unique: true
  end
end
