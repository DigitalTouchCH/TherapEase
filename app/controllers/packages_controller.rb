class PackagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  def index
    @packages = policy_scope(Package)
    @therapist = current_user.therapist

    # Collect all meetings of the therapist's packages
    @meetings_by_package = @therapist.packages.includes(meetings: :bookings).each_with_object({}) do |package, hsh|
      hsh[package] = package.meetings
    end

    # Group bookings by patient
    all_meetings = @meetings_by_package.values.flatten
    @bookings_grouped_by_patient = Booking.where(meeting: all_meetings).includes(:patient, meeting: [package: :service]).group_by(&:patient)
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
      redirect_to packages_path, notice: 'Package was successfully created.'
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
      redirect_to packages_path, notice: 'Package was successfully updated.'
    else
      render :edit, status: 422
    end
  end

  def destroy
    authorize @package
    @package.destroy
    redirect_to packages_url, notice: 'Package was successfully destroyed.'
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
