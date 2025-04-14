class Symptom < ApplicationRecord
  has_many :medicine_symptoms, dependent: :destroy
  has_many :medicines, through: :medicine_symptoms

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }, uniqueness: { case_sensitive: false }
  
  scope :ordered, -> { order(name: :asc) }
  scope :with_medicines, -> { joins(:medicines).distinct }
  
  before_save :capitalize_name
  
  private
  
  def capitalize_name
    self.name = name.capitalize if name.present?
  end
end
