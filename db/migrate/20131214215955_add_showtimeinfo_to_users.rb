class AddShowtimeinfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :showtimeinfo, :string
  end
end
