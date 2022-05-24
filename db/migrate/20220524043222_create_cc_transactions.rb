class CreateCcTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :cc_transactions do |t|
      t.string :card_number, null: false
      t.string :expiry_month, null: false
      t.string :expiry_year, null: false
      t.string :cvv, null: false
      t.string :zip, null: false
      t.date :billing_date, null: false
      t.numeric :amount, null: false, scale: 2, precision: 10

      t.timestamps
    end
    add_reference :cc_transactions, :merchant, foreign_key: true
    add_index :cc_transactions, :billing_date
  end
end
