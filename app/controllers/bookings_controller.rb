class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    set_meeting
    @booking = @meeting.bookings.build
  end

  def create
    @booking = @meeting.bookings.build(booking_params)
    if @booking.save
      redirect_to package_path(@meeting), notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def booking_params
    params.require(:booking).permit(:status, :info_public, :info_private, :patient_id, :meeting_id)
  end

end
