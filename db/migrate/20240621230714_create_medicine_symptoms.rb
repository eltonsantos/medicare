class CreateMedicineSymptoms < ActiveRecord::Migration[7.1]
  def change
    create_table :medicine_symptoms do |t|
      t.references :medicine, null: false, foreign_key: true
      t.references :symptom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
