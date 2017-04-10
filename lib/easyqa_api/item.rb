require 'faraday_middleware'

# @!macro project_token_param
#   @param project_token [String] token of project

# @!macro id_param
#   @param id [String] item id

# @!macro auth_user_param
#   @param user [Easyqapi::User] authenticated user in EasyQA

# @!macro see_default_user
#   @see @@default_user

# @!macro item_action_return
#   Have a class method analog
#   @macro auth_user_param
#   @return [Hash] item attribtues on EasyQA website
#   @see EasyqaApi::ClassMethodsSettable
#   @macro see_default_user

# @!macro item_action_return_with_attrs
#   @macro item_action_return
#   @param attrs [Hash] attributes for action
#   @option attrs [String] :project_token (@project_token) Project token on EasyQA

# @!macro item_action_return_with_attrs_and_id
#   @macro item_action_return_with_attrs
#   @option attrs [Fixnum] :id (@id) uniq item identeficator

# @!macro default_attributes
#   @!attribute [rw] id
#     @return [Fixnum] The uniq identeficator item on EasyQA website
#   @!attribute [rw] attributes
#     @return [Hash] item attributes from response body in your requests

# @!macro default_attributes_with_project_token
#   @macro default_attributes
#   @!attribute [rw] project_token
#     @return [String] your project token
module EasyqaApi
  # The class for representation EasyQA objects
  class Item
    extend ClassMethodsSettable

    # constant for Faradat connection by content type
    # @see EasyqaApi::Item.json_connection
    # @see EasyqaApi::Item.multipart_connection
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

    # Deafult user in EasyqaApi Items.
    #   If you set this attributes you can use any methods without set user in all methods
    # @see User#set_default!
    @@default_user = nil

    class << self
      # retrieve or create Faraday json connection
      # @return [Faraday::Connection] Faraday json connection
      def json_connection
        @json_connection ||= Faraday.new(url: EasyqaApi.configuration.url) do |faraday|
          faraday.request :json
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end
      end

      # retrieve or create Faraday multipart connection
      # @return [Faraday::Connection] Faraday multipart connection
      def multipart_connection
        @multipart_connection ||= Faraday.new(url: EasyqaApi.configuration.url) do |faraday|
          faraday.request :multipart
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end
      end

      # Send request to EasyQA api within default configuration
      # @param url [String] url for method
      # @param html_method [Symbol] html method for request
      # @param type [Symbol] type of request
      # @yield faraday request config
      # @example
      #   send_request('projects', :post) do |req|
      #     req.body = {
      #       project: {
      #         title: 'Test Project'
      #       },
      #       organization_id: 1,
      #       auth_token: 'IcdHzYZXDlX8SsjoOC5MV59lPVPzbaEUuUgZly3ESmopojMaN5pNlzOJCAV2_Rfe'
      #     }
      #   end
      # @return [Hash] response body
      # @raise [NotFoundError, PermissionError, RequestError, ValidationError] if request fail
      # @see EasyqaApi::Exception.check_response_status!
      # @see CONNECTION
      # @see EasyqaApi::Configuration
      def send_request(url, html_method, type = :json, &block)
        response = EasyqaApi::Item::CONNECTION[type][:instance].call.send(html_method) do |req|
          req.url EasyqaApi.configuration.api_path + url
          req.headers['Content-Type'] = EasyqaApi::Item::CONNECTION[type][:content_type]
          yield(req) if block
        end

        operation_status(response)
      end

      # Processing response
      # @param response [Faraday::Response] response of your request
      # @raise [NotFoundError, PermissionError, RequestError, ValidationError] if response not valid
      # @return [Hash] response body
      # @see EasyqaApi::Exception.check_response_status!
      def operation_status(response)
        EasyqaApi::Exception.check_response_status!(response)
        response.body
      end
    end

    def initialize(*_args)
    end

    # Install variables for Item instance if key in attribute has a valid setter in instance
    # @param arguments [Hash]
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
