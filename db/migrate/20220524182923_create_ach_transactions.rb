class CreateAchTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :ach_transactions do |t|
      t.string :account_number, null: false
      t.string :routing_number, null: false
      t.date :billing_date, null: false
      t.numeric :amount, null: false, scale: 2, precision: 10

      t.timestamps
    end
    add_reference :ach_transactions, :merchant, foreign_key: true
    add_index :ach_transactions, :billing_date
  end
end
