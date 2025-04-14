class HomeController < ApplicationController
  before_action :authenticate_profile!
  
  def index
    @symptoms = Symptom.ordered
    
    if current_profile.admin?
      @medicines = Medicine.ordered
      @expiring_medicines = Medicine.where("medicine_validity <= ?", 30.days.from_now)
                                   .order(:medicine_validity)
    else
      @medicines = Medicine.by_profile(current_profile.id).ordered
      @expiring_medicines = current_profile.medicines
                                        .where("medicine_validity <= ?", 30.days.from_now)
                                        .order(:medicine_validity)
    end
    
    # For the view to maintain compatibility
    @medicine = @medicines
    @symptom = @symptoms
  end
end
