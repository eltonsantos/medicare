class Medicine < ApplicationRecord
  has_many :medicine_symptoms, dependent: :destroy
  has_many :symptoms, through: :medicine_symptoms
  
  has_one_attached :picture
end
