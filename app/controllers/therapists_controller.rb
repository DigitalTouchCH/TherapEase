class TherapistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # @therapists = Therapist.all
    @therapists = policy_scope(Therapist)
  end

  def show
    @service = Therapist.find(params[:id])
  end

  def new
    @therapist = Therapist.new
  end

  def create
    @therapist = Therapists.new(therapist_params)
    if @therapist.save
      redirect_to therapist_path(@therapist), notice: 'Therapists was successfully created.'
    else
      render :new
    end
  end

  def edit
    @therapist = Therapists.find(params[:id])
  end

  def update
    @therapist = Therapists.find(params[:id])
    @therapist.update(service_params)
    redirect_to therapist_path(@therapist), notice: 'Therapists was successfully updated.'
  end

  def destroy
    @therapist = Therapists.find(params[:id])
    @therapist.destroy
    redirect_to therapists_path, status: :see_other, notice: 'Therapists was successfully deleted.'
  end

  private

  def therapist_params
    params.require(:therapist).permit(:information, :location_name, :location_address, :created_at, :updated_at,
                                    :user_id, :first_name, :last_name)
  end

end
