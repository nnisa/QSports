class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.text :description
      t.string :price
      t.string :brand
      t.string :size
      t.string :color

      t.timestamps
    end
  end
end
