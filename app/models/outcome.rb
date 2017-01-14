class Outcome < ApplicationRecord
  monetize :price_cents
  validates :description, presence: true
  validates :price, presence: true
  validates :date_of_transaction, presence: true
  belongs_to :category, optional: true
  register_currency :eur

  include Csvable

  def self.total
    Money.new sum(:price_cents)
  end

end
