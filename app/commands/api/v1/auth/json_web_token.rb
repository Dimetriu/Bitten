class Api::V1::Auth::JsonWebToken
  class << self

    def encode(payload, exp = 24.hours.from_now.to_i)
      payload[:exp] = exp
      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.credentials.secret_key_base).first
      HashWithIndifferentAccess.new(body)
    rescue
      nil
    end

  end
end
