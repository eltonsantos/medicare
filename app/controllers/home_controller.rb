class HomeController < ApplicationController
  before_action :authenticate_profile!
  
  def index
    @symptoms = Symptom.ordered
    
    if current_profile.admin?
      medicines_base = Medicine.ordered
    else
      medicines_base = Medicine.by_profile(current_profile.id).ordered
    end
    
    @expired_medicines = medicines_base.expired
    @expiring_soon_medicines = medicines_base.expiring_soon.where("medicine_validity >= ?", Date.today)
    
    # For the view to maintain compatibility
    @medicines = medicines_base
    @medicine = @medicines
    @symptom = @symptoms
  end
end
