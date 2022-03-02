class AddOmniauthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :spotify_photo, :string
    add_column :users, :spotify_token, :string
    add_column :users, :spotify_token_expiry, :datetime
  end
end
