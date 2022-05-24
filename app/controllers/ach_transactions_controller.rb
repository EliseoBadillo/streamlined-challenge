class AchTransactionsController < ApplicationController
  def index
    render :json => AchTransaction.all
  end

  def show
    render :json => AchTransaction.find(params[:id])
  end

  def create
    transaction = AchTransaction.new(ach_transaction_params)
    if transaction.save
      render :json => transaction
    else
      render :json => {
        :errors => transaction.errors.full_messages
      }, :status => :unprocessable_entity
    end
  end

  private

  def ach_transaction_params
    params.require(:ach_transaction).permit(:account_number, :routing_number, :billing_date, :amount, :merchant_id)
  end
end
