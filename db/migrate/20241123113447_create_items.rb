class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.decimal :tax_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
