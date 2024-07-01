class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[ show edit update destroy ]
  before_action :set_paper_trail_whodunnit

  def index
    if current_profile.role == "admin"
      @medicines = Medicine.all
    else
      @medicines = Medicine.where(profile_id: current_profile.id)
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
        format.turbo_stream { redirect_to medicines_url, notice: "Remédio registrado com sucesso." }
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
    if current_profile.role == "admin"
      @activities = PaperTrail::Version.where(item_type: "Medicine").order(created_at: :desc)
    else
      @activities = PaperTrail::Version.where(item_type: "Medicine", whodunnit: current_profile.id.to_s).order(created_at: :desc)
    end
  end

  private

    def set_paper_trail_whodunnit
      PaperTrail.request.whodunnit = current_profile.id if current_profile
    end

    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def medicine_params
      params.require(:medicine).permit(:picture, :name, :unit, :is_liquid, :quantity, :description, :medicine_validity, :medicine_insert, :used_to, :profile_id, symptom_ids: [])
    end
end
