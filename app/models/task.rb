class Task < ActiveRecord::Base
  include Concerns::Serializable
  
    
  has_many :comments
  belongs_to :stage
  # belongs_to :owner, class_name: 'Person'  
end
