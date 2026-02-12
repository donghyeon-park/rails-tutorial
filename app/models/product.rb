class Product < ApplicationRecord
  has_many :comments
  
  validates :name, 
            presence: true, 
            uniqueness: true, 
            length: { minimum: 2, maximum: 8 }
  
  VALID_STATUSES = %w[visible hidden]

  validates :status, inclusion: { in: VALID_STATUSES }

  def visible?
    status == "visible"
  end
end
