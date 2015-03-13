class AddOwnerToSale < ActiveRecord::Migration
  def change
  	add_column :sales, :owner, :integer
  end
end
