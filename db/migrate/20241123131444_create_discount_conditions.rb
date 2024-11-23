class CreateDiscountConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :discount_conditions do |t|
      t.references :item, null: false, foreign_key: true
      t.references :discount, null: false, foreign_key: true

      t.timestamps
    end
  end
end
