module EasyqaApi
  module ClassMethodsSettable
    METHODS = [:create, :show, :update, :delete].freeze

    def install_class_methods!(options = {})
      METHODS.each do |method_name|
        define_singleton_method method_name do |*attrs|
          instance = new
          instance.install_variables! instance.send(method_name, *attrs)
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
