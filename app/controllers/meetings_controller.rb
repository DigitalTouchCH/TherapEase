class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @therapist = current_user.therapist
    @meetings = policy_scope(Meeting).where.not(start_time: nil)
    @absences = policy_scope(Absence)
    @patients = policy_scope(Patient)
    @events_with_dates = @meetings.to_a + @absences.to_a
  end

  def show
    authorize @meeting
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
    @meeting = Meeting.find(params[:id])
    authorize @meeting
    if @meeting.update(meeting_params)
      redirect_to patient_path(@meeting.package.patient), notice: 'Meeting was successfully modified.'
    else
      render :edit
    end
  end


  def destroy
    authorize @meeting
    @meeting.destroy
    redirect_to meetings_url, notice: 'Meeting was successfully destroyed.'
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time, :status, :info_public, :info_private, :package_id, :therapist_id)
  end

end
