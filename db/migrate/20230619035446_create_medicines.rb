class CreateMedicines < ActiveRecord::Migration[7.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.integer :quantity
      t.date :medicine_validity
      t.text :medicine_insert
      t.string :used_to
      t.date :purchase_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
