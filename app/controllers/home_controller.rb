class HomeController < ApplicationController
  def index
    if current_user.role != "admin"
      @medicine = Medicine.where(user_id: current_user.id)
      @symptom = Symptom.all
      @expiring_medicines = current_user.medicines.where("medicine_validity <= ?", 10.days.from_now).order(:medicine_validity)
    else
      @medicine = Medicine.all
      @symptom = Symptom.all
      @expiring_medicines = Medicine.where("medicine_validity <= ?", 10.days.from_now).order(:medicine_validity)
    end
  end
end
