class AddPhotoUrlToConcerts < ActiveRecord::Migration[6.1]
  def change
    add_column :concerts, :photo_url, :text
  end
end
