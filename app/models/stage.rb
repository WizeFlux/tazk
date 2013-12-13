class Stage < ActiveRecord::Base
  include Concerns::Serializable

  def json_include; [:tasks]; end
  def json_methods; [:states]; end

  def states
    %w(default primary success info warning danger)
  end
  
  
  has_many :tasks
end
