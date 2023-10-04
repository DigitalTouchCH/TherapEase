class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:update_status]

  def index
    @therapist = current_user.therapist
    @meetings = policy_scope(Meeting).where.not(start_time: nil)
    @absences = policy_scope(Absence)
    @patients = policy_scope(Patient)
    @events_with_dates = @meetings.to_a + @absences.to_a
  end

  def show
    authorize @meeting
    if request.referrer&.include?(meetings_path)
      redirect_to meetings_path
    elsif request.referrer&.include?(patient_path(@meeting.package.patient))
      redirect_to patient_path(@meeting.package.patient)
    else
      redirect_to root_path
    end
  end

  def new
    @package = Package.find(params[:package_id]) if params[:package_id]
    @meeting = Meeting.new(package: @package)
    @duration = @package.service.duration_per_unit.to_i
    @final_available_slots = AvailableSlotsCalculator.new(@package.therapist, @package).call

    slot_class = Class.new do
      attr_reader :start_time

      def initialize(start_time)
        @start_time = start_time
      end
    end

    slots_array = @final_available_slots.values.flatten.map { |datetime| slot_class.new(datetime) }
    @final_available_slots_array = slots_array.group_by { |slot| slot.start_time.to_date }
    @final_slots_array = @final_available_slots_array.values.flatten

    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    authorize @meeting
    if @meeting.save
      redirect_to patient_path(@meeting.package.patient), notice: 'Meeting was successfully created.'
    else
      render :new
    end
  end

  def edit
    @media = Medium.where(therapist: current_user.therapist)
    @meeting = Meeting.find(params[:id]) # Chargez l'enregistrement existant
    @package = @meeting.package # Obtenez le package associé à la réunion
    @duration = @package.service.duration_per_unit.to_i
    @final_available_slots = AvailableSlotsCalculator.new(@package.therapist, @package).call

    slot_class = Class.new do
      attr_reader :start_time

      def initialize(start_time)
        @start_time = start_time
      end
    end

    slots_array = @final_available_slots.values.flatten.map { |datetime| slot_class.new(datetime) }
    @final_available_slots_array = slots_array.group_by { |slot| slot.start_time.to_date }
    @final_slots_array = @final_available_slots_array.values.flatten

    authorize @meeting
  end

  def update
    @media = Medium.where(therapist: current_user.therapist)
    @meeting = Meeting.find(params[:id])
    authorize @meeting

    if @meeting.update(meeting_params)
      if current_user.therapist
        redirect_to patient_path(@meeting.package.patient), notice: 'Meeting was successfully modified.'
      elsif current_user.patient
        redirect_to packages_path, notice: 'Meeting was successfully modified.'
      else
        redirect_to root_path
      end
    else
      render :edit
    end
  end


  def destroy
    authorize @meeting
    @meeting.destroy
    redirect_to meetings_url, notice: 'Meeting was successfully destroyed.'
  end

  def update_status
    @meeting = Meeting.find(params[:id])
    if @meeting.update(status: params[:status])
      redirect_to @meeting, notice: 'Status updated successfully.'
    else
      render :index
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time, :status,
                                    :info_public, :info_private, :package_id,
                                    :therapist_id, :patient_id, medium_ids: [])
  end
end
