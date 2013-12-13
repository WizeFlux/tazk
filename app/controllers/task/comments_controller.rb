class Task::CommentsController < ApplicationController
  include Concerns::Resource
  include Concerns::ParentResource



  before_filter :find_parent_resource
  before_filter :find_resources, only: %w(index)
  before_filter :new_resource, only: %w(create)
  before_filter :find_resource, only: %w(show update destroy)

  

  def resource_symbol; :comment; end
  def parent_resource_class; Task; end
  def permitted_params; %w(text); end
end
