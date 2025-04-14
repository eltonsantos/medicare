class Medicine < ApplicationRecord
  has_paper_trail

  belongs_to :profile
  
  has_many :medicine_symptoms, dependent: :destroy
  has_many :symptoms, through: :medicine_symptoms
  
  has_one_attached :picture
  has_one_attached :medicine_insert

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :unit, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :medicine_validity, presence: true
  validate :medicine_validity_cannot_be_in_past, on: :create
  validate :validate_medicine_insert_attachment

  scope :ordered, -> { order(name: :asc) }
  scope :expiring_soon, -> { where("medicine_validity <= ?", 30.days.from_now) }
  scope :expired, -> { where("medicine_validity < ?", Date.today) }
  scope :by_profile, ->(profile_id) { where(profile_id: profile_id) }
  scope :liquid, -> { where(is_liquid: true) }
  scope :solid, -> { where(is_liquid: false) }

  before_save :capitalize_name

  private

  def medicine_validity_cannot_be_in_past
    if medicine_validity.present? && medicine_validity < Date.today
      errors.add(:medicine_validity, "não pode estar no passado")
    end
  end

  def validate_medicine_insert_attachment
    if medicine_insert.attached?
      unless medicine_insert.content_type.in?(%w(application/pdf))
        errors.add(:medicine_insert, 'deve ser em formato PDF')
        medicine_insert.purge
      end
    end
  end

  def capitalize_name
    self.name = name.capitalize if name.present?
  end
end
