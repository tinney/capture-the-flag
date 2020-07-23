module Support
  module AuthHelpers
    def with_token_authorization(value)
      ActionController::HttpAuthentication::Token.encode_credentials(value)
    end
  end
end
