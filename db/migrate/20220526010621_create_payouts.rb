class CreatePayouts < ActiveRecord::Migration[7.0]
  def change
    create_table :payouts do |t|
      t.date :billing_date, null: false
      t.numeric :gross_cc_amount, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :cc_fees, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :net_cc_amount, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :gross_ach_amount, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :ach_fees, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :net_ach_amount, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :total_gross, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :total_fees, null: false, scale: 2, precision: 10, default: 0.00
      t.numeric :total_net, null: false, scale: 2, precision: 10, default: 0.00

      t.timestamps
    end
    add_reference :payouts, :merchant, foreign_key: true
    add_index :payouts, :billing_date
  end
end
