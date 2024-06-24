class CreateMedicines < ActiveRecord::Migration[7.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.integer :unit
      t.boolean :is_liquid, default: false
      t.integer :quantity
      t.text :description
      t.date :medicine_validity
      t.text :medicine_insert
      t.string :used_to
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
