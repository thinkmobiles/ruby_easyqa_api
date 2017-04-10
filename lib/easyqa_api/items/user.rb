module EasyqaApi
  # User representation from EasyQA website
  class User < Item
    # @!attribute [rw] auth_token
    #   @return [String] user auth_token on EasyQA website
    # @!attribute [rw] name
    #   @return [String] user name on EasyQA website
    attr_accessor :auth_token, :name

    # @param attrs [Hash] param for action
    # @option attrs [String] :email user email
    # @option attrs [String] :password user password
    # @note If you give user email and password you will be already signed on EasyQA.
    # @see auth_token
    # @see sign_in
    def initialize(attrs = {})
      super
      install_variables!(
        attrs[:email] && attrs[:password] ? sign_in(attrs[:email], attrs[:password]) : attrs
      )
    end

    # Sign in user on EasyQA website
    # @param email [String] Email user on EasyQA
    # @param password [String] password user on EasyQA
    # @return [Hash] user attributes on EasyQA webiste
    # @see auth_token
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

    # Sign out user on EasyQA website
    # @return [Hash] user attributes on EasyQA webiste
    # @see auth_token
    def sign_out
      send_request('sign_out', :delete) do |req|
        req.body = { auth_token: @auth_token }
      end
    end

    # Set default user on EasyqaApi
    # @return [EasyqaApi::User] current user
    # @see EasyqaApi::Item::@@default_user
    def set_default!
      @@default_user = self
    end
  end
end
