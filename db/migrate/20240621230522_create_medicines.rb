class CreateMedicines < ActiveRecord::Migration[7.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.integer :unit
      t.integer :quantity
      t.date :medicine_validity
      t.text :medicine_insert
      t.string :used_to
      t.date :purchase_date

      t.timestamps
    end
  end
end
