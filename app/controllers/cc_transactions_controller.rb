class CcTransactionsController < ApplicationController
  def index
    render :json => CcTransaction.all
  end

  def show
    render :json => CcTransaction.find(params[:id])
  end

  def create
    transaction = CcTransaction.new(cc_transaction_params)
    transaction_fee = (0.3 + (0.029 * transaction.amount)).round(2)
    net_amount = transaction.amount - transaction_fee
    payout = Payout.find_or_create_by(billing_date: cc_transaction_params[:billing_date], merchant_id: cc_transaction_params[:merchant_id])
    payout.gross_cc_amount += transaction.amount
    payout.cc_fees += transaction_fee
    payout.net_cc_amount += net_amount
    payout.total_gross += transaction.amount
    payout.total_fees += transaction_fee
    payout.total_net += net_amount
    if transaction.save && payout.save
      render :json => transaction
    else
      render :json => {
        :errors => transaction.errors.full_messages.concat(payout.errors.full_messages)
      }, :status => :unprocessable_entity
    end
  end

  private

  def cc_transaction_params
    params.require(:cc_transaction).permit(:card_number, :expiry_year, :expiry_month, :cvv, :zip, :billing_date, :amount, :merchant_id)
  end
end
