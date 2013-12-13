module Concerns::ParentResource
  extend ActiveSupport::Concern
  
  included do
    # helper_method :delivery_zone, :operator?
  end
  
  
  def parent_resource_class
    #Some::Class
  end
  
  def resource_symbol
    # should be setted
  end
  
  def find_resources
    @resources ||= resource_scope.load
  end

  def parent_resource_attribute
    params[(parent_resource_class.name.downcase + '_id').to_sym]
  end
  
  def parent_resource_attribute_kind
    :id
  end
  
  def find_parent_resource
    @parent_resource ||= parent_resource_class.find_by(
      parent_resource_attribute_kind => parent_resource_attribute
    )
  end
  
  def resource_scope
    @parent_resource.send resource_symbol.to_s.pluralize
  end
  
end