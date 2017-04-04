module EasyqaApi
  class NotFoundError < StandardError
  end

  class PermissionError < StandardError
  end

  class RequestError < StandardError
  end

  class Exception
    EXCEPTIONS = {
      404 => EasyqaApi::NotFoundError,
      403 => EasyqaApi::PermissionError,
      400 => EasyqaApi::RequestError
    }.freeze

    def self.check_response_status!(response)
      raise EXCEPTIONS[response.status], response.body['message'] || retrieve_mess(response.body) \
        if EXCEPTIONS[response.status]
    end

    def self.retrieve_mess(response_boddy)
      response_boddy.each_with_object('') do |(key, values), result_message|
        result_message << "#{key}: #{values.join('; ')}\n"
      end
    end
  end
end
