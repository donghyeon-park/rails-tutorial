class Product < ApplicationRecord
  include Visible
  has_many :comments
  
  validates :name, 
            presence: true, 
            uniqueness: true, 
            length: { minimum: 2, maximum: 8 }
end
