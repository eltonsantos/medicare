class Symptom < ApplicationRecord
  # Associations
  has_many :medicine_symptoms, dependent: :destroy
  has_many :medicines, through: :medicine_symptoms

  # Validations
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }, uniqueness: { case_sensitive: false }
  
  # Scopes
  scope :ordered, -> { order(name: :asc) }
  scope :with_medicines, -> { joins(:medicines).distinct }
  
  # Callbacks
  before_save :capitalize_name
  
  private
  
  def capitalize_name
    self.name = name.capitalize if name.present?
  end
end
