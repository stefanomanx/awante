class AddUrlToConcert < ActiveRecord::Migration[6.1]
  def change
    add_column :concerts, :url, :string
  end
end
