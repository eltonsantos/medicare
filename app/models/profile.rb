class Profile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :symptoms, dependent: :destroy
  has_many :medicines, dependent: :destroy
  has_many :members, dependent: :destroy

  enum role: { user: 0, admin: 1 }
end
