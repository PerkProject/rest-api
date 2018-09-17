class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :preview
      t.integer :price, default: 0, null: false

      t.timestamps
    end
  end
end
