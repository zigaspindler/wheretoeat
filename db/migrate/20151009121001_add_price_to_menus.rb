class AddPriceToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :price, :float
  end
end
