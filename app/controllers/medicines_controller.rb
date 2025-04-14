class MedicinesController < ApplicationController
  before_action :authenticate_profile!
  before_action :set_medicine, only: %i[show edit update destroy]
  before_action :set_paper_trail_whodunnit
  before_action :authorize_access, only: %i[show edit update destroy]

  def index
    @medicines = if current_profile.admin?
                   Medicine.includes(:profile, :symptoms, :picture_attachment)
                           .ordered
                 else
                   Medicine.by_profile(current_profile.id)
                           .includes(:symptoms, :picture_attachment)
                           .ordered
                 end
  end

  def show
  end

  def new
    @medicine = Medicine.new
  end

  def edit
  end

  def create
    @medicine = current_profile.medicines.new(medicine_params)

    respond_to do |format|
      if @medicine.save
        format.turbo_stream { redirect_to medicines_url, notice: "Remédio cadastrado com sucesso." }
      else
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @medicine.update(medicine_params)
        format.turbo_stream { redirect_to medicines_url, notice: "Remédio atualizado com sucesso.", status: :see_other }
      else
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @medicine.destroy!
    redirect_to medicines_url, notice: "Remédio excluído com sucesso.", status: :see_other
  end

  def activities
    @activities = if current_profile.admin?
                    PaperTrail::Version.where(item_type: "Medicine").order(created_at: :desc)
                  else
                    PaperTrail::Version.where(
                      item_type: "Medicine", 
                      whodunnit: current_profile.id.to_s
                    ).order(created_at: :desc)
                  end
  end

  private

  def set_paper_trail_whodunnit
    PaperTrail.request.whodunnit = current_profile.id if current_profile
  end

  def set_medicine
    @medicine = Medicine.find(params[:id])
  end

  def authorize_access
    return if current_profile.admin? || @medicine.profile_id == current_profile.id
    
    redirect_to medicines_path, alert: "Você não tem permissão para acessar este remédio."
  end

  def medicine_params
    params.require(:medicine).permit(
      :picture, 
      :name, 
      :unit, 
      :is_liquid, 
      :quantity, 
      :description, 
      :medicine_validity, 
      :medicine_insert, 
      :used_to, 
      symptom_ids: []
    )
  end
end
