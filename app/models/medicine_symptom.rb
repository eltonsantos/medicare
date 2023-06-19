class MedicineSymptom < ApplicationRecord
  belongs_to :medicine
  belongs_to :symptom
end
