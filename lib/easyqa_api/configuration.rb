# Simple gem for EasyQA api
module EasyqaApi
  # Saves the default config of gem
  class Configuration
    class << self
      attr_accessor :url, :api_version

      # Generate the valid api path for this api_version
      # @return [String] api path
      # @example
      #   EasyqaApi.configuration.api_path #=> '/api/v1/'
      def api_path
        "/api/v#{@api_version}/"
      end
    end

    @url = 'https://app.geteasyqa.com/'
    @api_version = 1
  end

  class << self
    attr_accessor :configuration
  end

  @configuration = Configuration

  # Setup your params.
  # @example You can change default params
  #   EasyqaApi.setup do |config|
  #     config.url = 'http://app.geteasyqa.com/'
  #     config.api_version = 1
  #   end
  def self.setup
    yield @configuration
  end
end
