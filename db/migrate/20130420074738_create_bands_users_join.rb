class CreateBandsUsersJoin < ActiveRecord::Migration
  def up
  	create_table 'bands_users', :id => false do |t|
  		t.column 'band_id', :integer
  		t.column 'user_id', :integer
  	end
  end

  def down
  	drop_table 'bands_users'
  end
end
