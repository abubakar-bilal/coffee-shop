class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.references :item, null: false, foreign_key: true
      t.decimal :discount_rate

      t.timestamps
    end
  end
end
