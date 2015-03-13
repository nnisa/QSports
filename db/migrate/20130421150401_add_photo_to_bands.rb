class AddPhotoToBands < ActiveRecord::Migration
  def change
    add_column :bands, :photo, :string
  end
end
