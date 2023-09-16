class TimeBlocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_week_availability
  before_action :set_time_block, only: [:edit, :update, :destroy]

  def new
    @week_availability = WeekAvailability.find(params[:week_availability_id])
    @time_block = @week_availability.time_blocks.build
    authorize @time_block
  end

  def show
    @time_block = @week_availability.time_blocks.find(params[:id])
    authorize @time_block
    redirect_to week_availability_path(@week_availability)
  end

  def create
    @time_block = @week_availability.time_blocks.build(params.require(:time_block).permit(:week_day, :start_time, :end_time))
    authorize @time_block
    if @time_block.save
      redirect_to week_availability_path(@week_availability), notice: 'Time Block was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @time_block
  end

  def update
    if @time_block.update(time_block_params)
      redirect_to week_availability_path(@week_availability), notice: 'Time Block was successfully updated.'
    else
      render :edit
    end
    authorize @time_block
  end

  def destroy
    authorize @time_block
    @time_block.destroy
    redirect_to week_availability_path(@week_availability), notice: 'Time Block was successfully deleted.'
  end



  private

  def set_week_availability
    @week_availability = WeekAvailability.find(params[:week_availability_id])
  end

  def set_time_block
    @time_block = @week_availability.time_blocks.find(params[:id])
  end

  def time_block_params
    params.require(:time_block).permit(:week_day, :start_time, :end_time)
  end
end
