module EasyqaApi
  # Class for processing exceptions
  class Exception
    # Exception for 404 response status
    class NotFoundError < StandardError
    end

    # Exception for 403 response status
    class PermissionError < StandardError
    end

    # Exception for 400 response status
    class RequestError < StandardError
    end

    # Exception for 422 response status
    class ValidationError < StandardError
    end

    # Constant for quickly find exception class by response status
    EXCEPTIONS = {
      404 => NotFoundError,
      403 => PermissionError,
      400 => RequestError,
      422 => ValidationError
    }.freeze

    # Check response status
    # @param response [Faraday::Response] the response of your request
    # @raise [NotFoundError] if status eql 404
    # @raise [PermissionError] if status eql 403
    # @raise [RequestError] if status eql 400
    # @raise [ValidationError] if status eql 422
    # @see EXCEPTIONS
    def self.check_response_status!(response)
      raise EXCEPTIONS[response.status], response.body['message'] || retrieve_mess(response.body) \
        if EXCEPTIONS[response.status]
    end

    # Retrieve message by response body
    # @param response_boddy [Hash]
    # @example
    #   EasyqaApi::Exception.retrieve_mess({ title: ["can`t be blank"]}) #=> "title: can`t be blank"
    def self.retrieve_mess(response_boddy)
      response_boddy.each_with_object('') do |(key, values), result_message|
        result_message << "#{key}: #{values.join('; ')}\n"
      end
    end
  end
end
