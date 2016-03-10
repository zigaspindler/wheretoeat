class AddShortreckoningsIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shortreckonings_id, :integer
  end
end
