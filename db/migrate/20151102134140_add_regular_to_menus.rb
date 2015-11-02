class AddRegularToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :regular, :boolean
  end
end
