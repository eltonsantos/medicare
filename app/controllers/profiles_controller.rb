class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update destroy]

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to profiles_path, notice: 'Perfil criado com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profiles_path, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, notice: 'Perfil excluído com sucesso.'
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:email, :name, :password, :password_confirmation, :role)
  end
end
