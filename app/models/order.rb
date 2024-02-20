class Order < ApplicationRecord
	# validates :payment_method, presence: true
	belongs_to :user
	belongs_to :address

	

	has_one_attached :image
	
	has_and_belongs_to_many :products

	has_one :payment,  dependent: :destroy

	enum :status, [:pending, :inprogress, :delivered, :shipped]
end