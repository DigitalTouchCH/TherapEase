class MediaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medium, only: [:show, :edit, :update, :destroy]

  def index
    @media = policy_scope(Medium)
  end

  def show
    authorize @medium
  end

  def new
    @medium = Medium.new
    authorize @medium
  end

  def create
    @medium = Medium.new(medium_params)
    @medium.therapist = Therapist.where(user: current_user)[0]
    authorize @medium
    if @medium.save
      redirect_to media_path
    else
      render :new, status: 422
    end
  end

  def edit
    authorize @medium
  end

  def update
    authorize @medium
    if @medium.update(medium_params)
      redirect_to media_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    authorize @medium
    @medium.destroy
    redirect_to media_path
  end

  private

  def set_medium
    @medium = Medium.find(params[:id])
  end

  def medium_params
    new_params = params.require(:medium).permit(:title, :description, :url, meetings: [])
    meetings = []
    new_params[:meetings].each { |meeting_id| meetings << Meeting.find(meeting_id) unless meeting_id.empty? }
    new_params[:meetings] = meetings
    new_params
  end
end
