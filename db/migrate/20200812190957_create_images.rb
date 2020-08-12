class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :url, null: false
      t.date :date, null: false
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
