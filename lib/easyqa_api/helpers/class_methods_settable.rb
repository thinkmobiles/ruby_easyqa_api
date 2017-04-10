module EasyqaApi
  # This module provides extends instance methods to class
  module ClassMethodsSettable
    # List of allowed instance methods
    METHODS = [:create, :show, :update, :delete].freeze

    # Provide instance methods to class
    # @param options [Hash] options for install class methods
    # @option options [Array] :only only few methods from METHODS constant
    # @option options [Array] :except except few methods from METHODS constant
    # @see METHODS
    # @example With only params
    #   install_class_methods! only: [:update, :delete]
    # @example With except params
    #   install_class_methods! except: [:create]
    def install_class_methods!(options = {})
      METHODS.each do |method_name|
        define_singleton_method method_name do |*attrs|
          instance = new
          instance.install_variables!(
            instance.send(method_name, *attrs).merge(attrs.find { |attr| attr.is_a? Hash } || {})
          )
          instance
        end if method_permitted?(options, method_name)
      end
    end

    private

    def method_permitted?(options, method_name)
      (options[:only].nil? && options[:except].nil?) || \
        (options[:only] && options[:only].include?(method_name)) || \
        (options[:except] && !options[:except].include?(method_name))
    end
  end
end
