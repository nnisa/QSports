class CreateSalesUsersJoin < ActiveRecord::Migration
  def up
  	create_table 'sales_users', :id => false do |t|
  		t.column 'sale_id', :integer
  		t.column 'user_id', :integer
  	end
  end

  def down
  	drop_table 'sales_users'
  end
end
