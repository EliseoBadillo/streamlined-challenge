class CcTransactionsController < ApplicationController
  def index
    render :json => CcTransaction.all
  end

  def show
    render :json => CcTransaction.find(params[:id])
  end

  def create
    transaction = CcTransaction.new(cc_transaction_params)
    if transaction.save
      render :json => transaction
    else
      render :json => {
        :errors => transaction.errors.full_messages
      }, :status => :unprocessable_entity
    end
  end

  private

  def cc_transaction_params
    params.require(:cc_transaction).permit(:card_number, :expiry_year, :expiry_month, :cvv, :zip, :billing_date, :amount, :merchant_id)
  end
end
