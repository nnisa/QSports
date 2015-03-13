class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
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
