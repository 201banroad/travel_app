class AddWishlistTextToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :wishlist_text, :text
  end
end
