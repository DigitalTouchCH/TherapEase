class PackagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  def index
    @packages = policy_scope(Package)
    @patient = current_user.patient
    @therapist = current_user.therapist

    if @therapist
      # Collect all meetings of the therapist's packages
      @meetings_by_package = @therapist.packages.includes(:meetings).each_with_object({}) do |package, hsh|
        hsh[package] = package.meetings
      end
      # Fetch all meetings
      all_meetings = @meetings_by_package.values.flatten
      # Group meetings by patient through their package
      @meetings_grouped_by_patient = all_meetings.group_by { |meeting| meeting.package.patient }
    end
  end

  def show
    authorize @package
  end

  def new
    @package = Package.new
    authorize @package
  end

  def create
    @package = Package.new(package_params)
    authorize @package
    if @package.save
      if current_user&.therapist
        redirect_to meetings_path, notice: 'Package was successfully created.'
      else
        redirect_to packages_path, notice: 'Package was successfully created.'
      end
    else
      render :new, status: 422
    end
  end

  def edit
    authorize @package
  end

  def update
    authorize @package
    if @package.update(package_params)
      if current_user&.therapist
        redirect_to meetings_path, notice: 'Package was successfully updated.'
      else
        redirect_to packages_path, notice: 'Package was successfully updated.'
      end
    else
      render :edit, status: 422
    end
  end

  def destroy
    authorize @package
    @package.destroy
    redirect_to meetings_path, notice: 'Package was successfully destroyed.'
  end

  private

  def set_package
    @package = Package.find(params[:id])
  end

  def package_params
    params.require(:package).permit(:num_of_session, :info_public, :info_private, :insurance_name,
      :insurance_number, :insurance_type, :package_type, :patient_id, :therapist_id, :service_id)
  end
end
