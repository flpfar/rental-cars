class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: 'Cliente cadastrado com sucesso!'
    else
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :document, :email)
  end
end