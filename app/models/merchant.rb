class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :cc_transactions
  has_many :ach_transactions
end
