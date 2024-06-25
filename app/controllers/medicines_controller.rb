class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[ show edit update destroy ]
  before_action :set_paper_trail_whodunnit

  def index
    if current_user.role == "admin"
      @medicines = Medicine.all
    else
      @medicines = Medicine.where(user_id: current_user.id)
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
    @medicine = current_user.medicines.new(medicine_params)

    if @medicine.save
      redirect_to medicines_url, notice: "Medicine was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @medicine.update(medicine_params)
      redirect_to medicines_url, notice: "Medicine was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medicine.destroy!
    redirect_to medicines_url, notice: "Medicine was successfully destroyed.", status: :see_other
  end

  def activities
    if current_user.role == "admin"
      @activities = PaperTrail::Version.where(item_type: "Medicine").order(created_at: :desc)
    else
      @activities = PaperTrail::Version.where(item_type: "Medicine", whodunnit: current_user.id.to_s).order(created_at: :desc)
    end
  end

  private
  
    def set_paper_trail_whodunnit
      PaperTrail.request.whodunnit = current_user.id if current_user
    end

    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def medicine_params
      params.require(:medicine).permit(:name, :unit, :is_liquid, :quantity, :description, :medicine_validity, :medicine_insert, :used_to, :user_id, symptom_ids: [])
    end
end
