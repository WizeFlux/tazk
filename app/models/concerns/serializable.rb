module Concerns::Serializable
  extend ActiveSupport::Concern

  def as_json(options={})
    @methods ||= []
    @include ||= []
    @except ||= []
    
    options[:methods] ||= []
    options[:methods] += json_methods + @methods
    
    options[:include] ||= []
    options[:include] += json_include + @include
    
    options[:except] ||= []
    options[:except] += json_except + @except
    
    super(options)
  end
  
  included do
    
  end
  
  def add_json_method(method_key)
    @methods ||= []
    @methods << method_key
  end

  def add_json_except(except_key)
    @except ||= []
    @except << except_key
  end
  
  def add_json_include(include_key)
    @include ||= []
    @include << include_key
  end
  
  def json_except; []; end
  def json_include; []; end
  def json_methods; []; end
end