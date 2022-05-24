class CcTransaction < ApplicationRecord
  encrypts :card_number, :expiry_year, :expiry_month, :cvv, :zip
  validates_presence_of :card_number, :expiry_year, :expiry_month, :cvv, :zip, :billing_date, :amount
  validates :card_number, length: { is: 16 }
  validates :card_number, numericality: { only_integer: true }
  validate :card_number_is_valid
  validates :expiry_year, length: { is: 4 }
  validates :expiry_year, numericality: { only_integer: true }
  validates :expiry_month, inclusion: { in: %w(01 02 03 04 05 06 07 08 09 10 11 12), message: "%{value} is not a valid expiration month"}
  validate :expiration_is_valid
  validates :cvv, length: { is: 3 }
  validates :cvv, numericality: { only_integer: true }
  validates :zip, length: { is: 5 }
  validates :zip, numericality: { only_integer: true }
  validates :amount, numericality: true

  belongs_to :merchant

  def card_number_is_valid
    if card_number[0..3] == "1111" || card_number[0..3] == "8888"
      errors.add(:card_number, "is invalid")
    end
  end

  def expiration_is_valid
    today = Date.today
    if expiry_year.to_i < today.year
      errors.add(:expiry_year, "is invalid")
    elsif expiry_year.to_i == today.year
      if expiry_month.to_i <= today.month
        errors.add(:expiry_month, "is invalid")
      end
    end
  end
end
