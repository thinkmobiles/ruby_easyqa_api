module EasyqaApi
  class Configuration
    class << self
      attr_accessor :url, :api_version

      def api_path
        "/api/v#{@api_version}/"
      end
    end

    @url = 'http://localhost:3000/'
    @api_version = 1
  end

  class << self
    attr_accessor :configuration
  end

  @configuration = Configuration

  def self.setup
    yield @configuration
  end
end
