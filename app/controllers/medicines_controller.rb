class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[ show edit update destroy ]

  # GET /medicines
  def index
    @medicines = Medicine.all
  end

  # GET /medicines/1
  def show
  end

  # GET /medicines/new
  def new
    @medicine = Medicine.new
  end

  # GET /medicines/1/edit
  def edit
  end

  # POST /medicines
  def create
    @medicine = Medicine.new(medicine_params)

    if @medicine.save
      redirect_to @medicine, notice: "Medicine was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /medicines/1
  def update
    if @medicine.update(medicine_params)
      redirect_to @medicine, notice: "Medicine was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /medicines/1
  def destroy
    @medicine.destroy!
    redirect_to medicines_url, notice: "Medicine was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medicine_params
      params.require(:medicine).permit(:name, :unit, :quantity, :medicine_validity, :medicine_insert, :used_to, :purchase_date)
    end
end
