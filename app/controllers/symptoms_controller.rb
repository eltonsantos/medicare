class SymptomsController < ApplicationController
  before_action :set_symptom, only: %i[ show edit update destroy ]

  # GET /symptoms
  def index
    @symptoms = Symptom.all
  end

  # GET /symptoms/1
  def show
  end

  # GET /symptoms/new
  def new
    @symptom = Symptom.new
  end

  # GET /symptoms/1/edit
  def edit
  end

  # POST /symptoms
  def create
    @symptom = Symptom.new(symptom_params)

    if @symptom.save
      redirect_to @symptom, notice: "Symptom was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /symptoms/1
  def update
    if @symptom.update(symptom_params)
      redirect_to @symptom, notice: "Symptom was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /symptoms/1
  def destroy
    @symptom.destroy!
    redirect_to symptoms_url, notice: "Symptom was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_symptom
      @symptom = Symptom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def symptom_params
      params.require(:symptom).permit(:name, :description)
    end
end
