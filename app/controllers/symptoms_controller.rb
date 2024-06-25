class SymptomsController < ApplicationController
  before_action :set_symptom, only: %i[ show edit update destroy ]

  def index
    @symptoms = Symptom.all
  end

  def show
  end

  def new
    @symptom = Symptom.new
  end

  def edit
  end

  def create
    @symptom = Symptom.new(symptom_params)

    if @symptom.save
      redirect_to symptoms_url, notice: "Symptom was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @symptom.update(symptom_params)
      redirect_to symptoms_url, notice: "Symptom was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @symptom.destroy!
    redirect_to symptoms_url, notice: "Symptom was successfully destroyed.", status: :see_other
  end

  private
    def set_symptom
      @symptom = Symptom.find(params[:id])
    end

    def symptom_params
      params.require(:symptom).permit(:name, :description)
    end
end
