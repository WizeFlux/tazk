module Concerns::Resource
  extend ActiveSupport::Concern
  
  included do
    # helper_method :delivery_zone, :operator?
  end
  
  # Configureation
  def resource_scope
    #Some::Class
  end
  
  def permitted_params
    []
  end
  
  def added_params
    {}
  end

  def extend_resources_attributes(resource)
    {}
  end
  
  def resource_attribute_kind
    :id
  end

  # Methods
  def new_resource
    @resource ||= resource_scope.new resource_params
  end
  
  def resource_symbol
    resource_scope.name.downcase.to_sym
  end
  
  def find_resource
    @resource ||= resource_scope.find_by(resource_attribute_kind => params[:id])
  end
  
  def find_resources
    @resources ||= resource_scope.all
  end
  
  def respond_with_json_resource
    respond_to do |format|
      format.html
      format.json { render json: @resource }
    end 
  end
  
  def resource_params
    params.require(resource_symbol).permit(permitted_params).merge(added_params)
  end
  
  def extend_resources!
    @resources = @resources.to_a
    ((@resources || []) + [(@resource if @resource)]).compact.each do |resource|
      extend_resources_attributes(resource).each do |key, value|
        resource.class_eval { attr_accessor key }
        resource.send(key.to_s + '=', value)
        resource.add_json_method key
      end
    end
  end
  


  # Actions
  def index
    respond_to do |format|
      format.html
      format.json { render json: @resources.to_a }
    end
  end
  
  def create
    if @resource.save
      respond_with_json_resource
    else
      render :status => 401
    end
  end
  
  def update
    if @resource.update_attributes resource_params
      respond_with_json_resource
    else
      render :status => 401
    end
  end
  
  def show
    respond_with_json_resource
  end
  
  def destroy
    if @resource.destroy
      respond_with_json_resource
    else
      render :status => 401
    end
  end
end