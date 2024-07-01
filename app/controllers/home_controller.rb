class HomeController < ApplicationController
  def index
    if current_profile.role != "admin"
      @medicine = Medicine.where(profile_id: current_profile.id)
      @symptom = Symptom.all
      @expiring_medicines = current_profile.medicines.where("medicine_validity <= ?", 10.days.from_now).order(:medicine_validity)
    else
      @medicine = Medicine.all
      @symptom = Symptom.all
      @expiring_medicines = Medicine.where("medicine_validity <= ?", 10.days.from_now).order(:medicine_validity)
    end
  end
end
