class Medicine < ApplicationRecord
  has_paper_trail

  belongs_to :user
  
  has_many :medicine_symptoms, dependent: :destroy
  has_many :symptoms, through: :medicine_symptoms
  
  has_one_attached :picture
  has_one_attached :medicine_insert

  validates :name, :unit, :quantity, :medicine_validity, presence: true
  validate :validate_medicine_insert_attachment

  private

  def validate_medicine_insert_attachment
    if medicine_insert.attached?
      unless medicine_insert.content_type.in?(%w(application/pdf))
        errors.add(:medicine_insert, 'Deve ser em formato PDF')
        medicine_insert.purge
      end
    end
  end
end
