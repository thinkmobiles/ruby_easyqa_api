require 'faraday_middleware'

module EasyqaApi
  class Item
    extend ClassMethodsSettable

    CONNECTION = {
      json: {
        instance: -> { json_connection },
        content_type: 'application/json'
      },
      multipart: {
        instance: -> { multipart_connection },
        content_type: 'multipart/form-data'
      }
    }.freeze

    class << self
      def json_connection
        @json_connection ||= Faraday.new(url: EasyqaApi.configuration.url) do |faraday|
          faraday.request :json
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end
      end

      def multipart_connection
        @multipart_connection ||= Faraday.new(url: EasyqaApi.configuration.url) do |faraday|
          faraday.request :multipart
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end
      end

      def send_request(url, html_method, type = :json, &block)
        response = EasyqaApi::Item::CONNECTION[type][:instance].call.send(html_method) do |req|
          req.url EasyqaApi.configuration.api_path + url
          req.headers['Content-Type'] = EasyqaApi::Item::CONNECTION[type][:content_type]
          yield(req) if block
        end

        operation_status(response)
      end

      def operation_status(response)
        EasyqaApi::Exception.check_response_status!(response)
        response.body
      end
    end

    def initialize(*_args)
    end

    @@default_user = nil

    def install_variables!(arguments)
      allowed_methods = retrive_allowed_methods
      arguments.each do |key, value|
        method_name = "#{key}=".to_sym
        send(method_name, value) if allowed_methods.include? method_name
      end
    end

    private

    def send_request(*attrs, &block)
      self.class.send_request(*attrs, &block)
    end

    def retrive_allowed_methods
      public_methods.select { |method_name| method_name =~ /[a-z]=$/ }
    end
  end
end
