module EasyqaApi
  class User < Item
    attr_accessor :auth_token, :name

    def initialize(attrs = {})
      super
      install_variables!(
        attrs[:email] && attrs[:password] ? sign_in(attrs[:email], attrs[:password]) : attrs
      )
    end

    def sign_in(email, password)
      send_request('sign_in', :post) do |req|
        req.body = {
          user: {
            email: email,
            password: password
          }
        }
      end
    end

    def sign_out
      send_request('sign_out', :delete) do |req|
        req.body = { auth_token: auth_token || @auth_token }
      end
    end

    def set_default!
      @@default_user = self
    end
  end
end
