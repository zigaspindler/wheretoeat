class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :description
      t.date :date
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
