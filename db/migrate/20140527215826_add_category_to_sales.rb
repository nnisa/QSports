class AddCategoryToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :category, :string
  end
end
