class WeekAvailabilitiesController < ApplicationController
  include Pundit

  before_action :authenticate_user!
  before_action :set_therapist

  def index
    @week_availabilities = policy_scope(WeekAvailability).where(therapist: current_user.therapist)
  end

  def new
    @week_availability = WeekAvailability.new
    authorize @week_availability
  end

  def show
    @week_availability = WeekAvailability.find(params[:id])
    authorize @week_availability
    redirect_to week_availabilities_path
  end

  def create
    @week_availability = WeekAvailability.new(week_availability_params)
    @week_availability.therapist = current_user.therapist
    authorize @week_availability

    if @week_availability.save
      redirect_to week_availabilities_path, notice: 'Week Availability was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @week_availability = WeekAvailability.find(params[:id])
    @week_availability.destroy
    redirect_to week_availabilities_path, notice: 'Week Availability was successfully deleted.', status: :found
  end

  def edit
    @week_availability = WeekAvailability.find(params[:id])
    authorize @week_availability
  end

  def update
    @week_availability = WeekAvailability.find(params[:id])
    authorize @week_availability
    if @week_availability.update(week_availability_params)
      redirect_to week_availabilities_path, notice: 'Week Availability was successfully updated.'
    else
      render :edit
    end
  end

  private

  def week_availability_params
    params.require(:week_availability).permit(:valid_from, :valid_until)
  end

  def set_therapist
    @therapist = current_user.therapist
    redirect_to(root_path, alert: "You are not a therapist!") unless @therapist
  end





  # Handle authorization errors gracefully
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
