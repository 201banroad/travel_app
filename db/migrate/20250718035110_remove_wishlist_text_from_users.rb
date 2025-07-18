class RemoveWishlistTextFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :wishlist_text, :string
  end
end
