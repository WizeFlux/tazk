class StagesController < ApplicationController
  include Concerns::Resource
  
  before_filter :new_resource, only: %w(create)
  before_filter :find_resource, only: %w(show update destroy)
  before_filter :find_resources, only: %w(index)
  
  
  def resource_scope; Stage; end
  def permitted_params; %w(name tags); end
end
