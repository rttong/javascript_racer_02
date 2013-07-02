class Player < ActiveRecord::Base
  validates_uniqueness_of :name
  
  has_many :rounds
  has_many :games, :through => :rounds
  
end
