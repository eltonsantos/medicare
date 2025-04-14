class Profile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :medicines, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :symptoms, through: :medicines
  
  enum role: { user: 0, admin: 1 }
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  
  scope :ordered, -> { order(name: :asc) }
  
  def medicine_count
    medicines.count
  end
  
  def expired_medicines_count
    medicines.expired.count
  end
  
  def expiring_medicines_count
    medicines.expiring_soon.count
  end
end
