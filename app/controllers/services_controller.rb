class ServicesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index

    # @services = Service.all
    @services = policy_scope(Service)

    # if params[:query].present?
    # sql_subquery = "name ILIKE :query OR category ILIKE :query"
    # @services = @services.where(sql_subquery, query: "%#{params[:query]}%")
  end

  def show
    @service = Service.find(params[:id])
    authorize @service
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to service_path(@service), notice: 'Service was successfully created.'
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    @service.update(service_params)
    redirect_to service_path(@service), notice: 'Service was successfully updated.'
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to services_path, status: :see_other, notice: 'Service was successfully deleted.'
  end

  private

  def service_params
    params.require(:service).permit(:active, :name, :paiement_methode, :insurance_visibility, :place_type,
                                    :price_visibility, :price_per_unit, :duration_per_unit, :color, :created_at,
                                    :updated_at)
  end
end
