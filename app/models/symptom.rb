class Symptom < ApplicationRecord
  has_many :medicine_symptoms, dependent: :destroy
  has_many :medicines, through: :medicine_symptoms
end
