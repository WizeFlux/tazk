class Task < ActiveRecord::Base
  include Concerns::Serializable
  
    
  has_many :comments
  belongs_to :stage
end
