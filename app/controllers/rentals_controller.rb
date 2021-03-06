class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @customers = Customer.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    @customers = Customer.all
    @car_categories = CarCategory.all
    @rental.user = current_user

    if @rental.save
      redirect_to @rental, notice: 'Agendamento realizado com sucesso'
    else
      render :new
    end
  end

  def search
    @is_search = true
    @rentals = Rental.where('code LIKE UPPER(?)', "%#{params[:q]}%")
    render :index
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :customer_id, :car_category_id)
  end
end