class AddStarTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :star_token, :string
    add_index  :users, :star_token
  end
end
