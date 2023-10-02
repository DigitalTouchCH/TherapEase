class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :set_therapist

  def index
    @patients = policy_scope(Patient)
  end

  def show
    authorize @patient
    @packages = Package.where(therapist: @therapist, patient: @patient)
    @patient.age = new_age
    @meetings_by_status_per_package = {}

    @packages.each do |package|
      @meetings_by_status_per_package[package.id] = Meeting.where(package: package).group(:status).count
    end
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
      if current_user.therapist
        redirect_to patient_path(@patient), notice: 'Information updated successfully!'
      else current_user.patient
        redirect_to packages_path, notice: 'Information updated successfully!'
      end
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
    @patient = if current_user.patient
                 current_user.patient
               else
                 Patient.find(params[:id])
               end
  end

  def set_therapist
    if current_user.therapist
      @therapist = current_user.therapist
      @patients = @therapist.packages.includes(:patient).map(&:patient).uniq
    elsif current_user.patient
      @patients = [@patient]
    end
  end


  def new_age
    today = Date.today
    age = today.year - @patient.date_of_birth.year
    age -= 1 if @patient.date_of_birth.strftime("%m%d").to_i > today.strftime("%m%d").to_i
    age
  end

  def patient_params
    params.require(:patient).permit(:date_of_birth, :age, :addresse,
                                    :tel_1, :tel_2, :contact_name,
                                    :contact_info, :contact_tel, :info_private,
                                    :info_public, :first_name, :last_name)
  end
end
