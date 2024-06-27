class HomeController < ApplicationController
  def index
    if current_user.role != "admin"
      @medicine = Medicine.where(user_id: current_user.id)
      @symptom = Symptom.all
    else
      @medicine = Medicine.all
      @symptom = Symptom.all
    end
  end
end
