class AddConditionToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :condition, :string
  end
end
