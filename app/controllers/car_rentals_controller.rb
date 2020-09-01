class CarRentalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @rental = Rental.find(params[:rental_id])
    # @available_cars = Car.where(car_model: @rental.car_category.car_models)
    @available_cars = @rental.car_category.cars
    @car_rental = CarRental.new
  end

  def create
    @rental = Rental.find(params[:rental_id])
    @car_rental = @rental.build_car_rental(car_rental_params)
    @car_rental.save!
    redirect_to @rental, notice: 'Locação iniciada com sucesso'
  end

  private

  def car_rental_params
    params.require(:car_rental).permit(:car_id, :driver_license_number)
      .merge(user_id: current_user.id, start_date: Time.zone.now)
  end
end
