# frozen_string_literal: true

module Doorkeeper
  module OAuth
    class TokenResponse
      attr_reader :token

      def initialize(token)
        @token = token
      end

      def body
        {
          "accessToken" => token.plaintext_token,
          "tokenType" => token.token_type,
          "expiresIn" => token.expires_in_seconds,
          "refreshToken" => token.plaintext_refresh_token,
          "scope" => token.scopes_string,
          "createdAt" => token.created_at.to_i,
        }.reject { |_, value| value.blank? }
      end

      def status
        :ok
      end

      def headers
        {
          "Cache-Control" => "no-store",
          "Pragma" => "no-cache",
          "Content-Type" => "application/json; charset=utf-8",
        }
      end
    end
  end
end
