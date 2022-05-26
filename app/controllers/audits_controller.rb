class AuditsController < ApplicationController
  def transactions
    billing_date = params[:billing_date]
    cc_transactions = CcTransaction.where(billing_date: billing_date).to_a
    ach_transactions = AchTransaction.where(billing_date: billing_date).to_a
    all_transactions = cc_transactions + ach_transactions
    grouped_transactions = all_transactions.group_by do |transaction|
      transaction.merchant.name
    end
    render :json => grouped_transactions
  end

  def payouts
    render :json => Payout.all
  end

  def payout
    payout = Payout.find(params[:id])
    cc_transactions = CcTransaction.where(merchant_id: payout.merchant_id, billing_date: payout.billing_date).to_a
    ach_transactions = AchTransaction.where(merchant_id: payout.merchant_id, billing_date: payout.billing_date).to_a
    render :json => {
      **payout.attributes,
      merchant_name: payout.merchant.name,
      transactions: cc_transactions + ach_transactions
    }
  end
end
