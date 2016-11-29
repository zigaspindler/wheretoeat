class AddMenuParserToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :menu_parser, :string
  end
end
