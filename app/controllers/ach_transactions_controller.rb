class AchTransactionsController < ApplicationController
  def index
    render :json => AchTransaction.all
  end

  def show
    render :json => AchTransaction.find(params[:id])
  end

  def create
    transaction = AchTransaction.new(ach_transaction_params)
    transaction_fee = (1.0 + (0.01 * transaction.amount)).round(2)
    net_amount = transaction.amount - transaction_fee
    payout = Payout.find_or_create_by(billing_date: ach_transaction_params[:billing_date], merchant_id: ach_transaction_params[:merchant_id])
    payout.gross_ach_amount += transaction.amount
    payout.ach_fees += transaction_fee
    payout.net_ach_amount += net_amount
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

  def ach_transaction_params
    params.require(:ach_transaction).permit(:account_number, :routing_number, :billing_date, :amount, :merchant_id)
  end
end
