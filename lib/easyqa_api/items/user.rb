module EasyqaApi
  class User < Item
    attr_accessor :auth_token, :name

    def initialize(email = nil, password = nil)
      super
      @auth_token, @name = sign_in(email, password).values if email && password
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

    def sign_out(auth_token = nil)
      send_request('sign_out', :delete) do |req|
        req.body = { auth_token: auth_token || @auth_token }
      end
    end
  end
end
