require 'faraday_middleware'

class EasyqaApi::Item
  def initialize(*_args)
    set_connection
  end

  private

  def set_connection
    @connection = Faraday.new(url: EasyqaApi.configuration.url) do |faraday|
      faraday.request :json
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
  end

  def send_request(url, html_method, &block)
    response = @connection.send(html_method) do |req|
      req.url EasyqaApi.configuration.api_path + url
      req.headers['Content-Type'] = 'application/json'
      yield(req) if block
    end

    operation_status(response)
  end

  def operation_status(response)
    case response.status
    when 404
      raise EasyqaApi::NotFoundError, response.body['message']
    else
      response.body
    end
  end
end
