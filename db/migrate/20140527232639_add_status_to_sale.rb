class AddStatusToSale < ActiveRecord::Migration
  def change
  	add_column :sales, :status, :boolean, default: false
  end
end
