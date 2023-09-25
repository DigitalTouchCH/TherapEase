class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :set_therapist

  def index
    @patients = policy_scope(Patient)
  end

  def show
    authorize @patient
    @packages = Package.where(therapist: @therapist)
  end

  def new
    @patient = Patient.new
    authorize @patient
  end

  def create
    @patient = Patient.new(patient_params)
    authorize @patient
    if @patient.save
      redirect_to patients_path, notice: 'Patient was successfully created.'
    else
      render :new, status: 422
    end
  end

  def edit
    authorize @patient
  end

  def update
    authorize @patient
    if @patient.update(patient_params)
      redirect_to patients_path, notice: 'Patient was successfully updated.'
    else
      render :edit, status: 422
    end
  end

  def destroy
    authorize @patient
    @patient.destroy
    redirect_to patients_url, notice: 'Patient was successfully destroyed.'
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def set_therapist
    @therapist = current_user.therapist
    @patients = current_user.therapist.packages.includes(:patient).map(&:patient).uniq
  end

  def patient_params
    params.require(:patient).permit(:date_of_birth, :age, :addresse, :tel_1, :tel_2, :contact_name, :contact_info, :contact_tel, :info_private, :info_public, :first_name, :last_name)
  end
end
