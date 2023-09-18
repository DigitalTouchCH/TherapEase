class AbsencesController < ApplicationController
  # before_action :authenticate_user!
  before_action :validate_therapist
  before_action :set_absence, only: [:edit, :update]

  def index
    @absences = policy_scope(Absence)
  end

  def new
    @absence = Absence.new
    authorize @absence
  end

  def create
    @absence = Absence.new(absence_params)
    @absence.therapist = Therapist.where(user: current_user)[0]
    authorize @absence
    if @absence.save
      redirect_to meetings_path
    else
      render :new, status: 422
    end
  end

  def edit
    authorize @absence
  end

  def update
    authorize @absence
    @absence.update(absence_params)
    redirect_to meetings_path
  end

  private

  def absence_params
    params.require(:absence).permit(:start_time, :end_time, :reason, :therapist_id)
  end

  def set_absence
    @absence = Absence.find(params[:id])
  end

  def validate_therapist
    redirect_to root_path unless Therapist.where(user: current_user).exists?
  end
end
