class Api::V1::Urls::ShortenUrl
  prepend SimpleCommand

  def self.normalize(body)
    uri = URI(body)
    uri.scheme.nil? ? uri = URI('http://' << uri.to_s).to_s : uri
  end

  def initialize(owner, body)
    @owner = owner
    @body  = Api::V1::Urls::ShortenUrl.normalize(body)
  end

  def call
    return url.save if url.valid?

    errors.add(:url, I18n.t('url.invalid_url'))
  end

  private
    attr_reader :owner, :body

    def url
      url = Url.new(
              user_id: owner.id,
              body: body,
              shortened_body: generate_short_body
            )
    end

    def generate_short_body
      (1..3)
      .collect { rand(9) }
      .map { |i| i.to_s << ('a'..'z').to_a.sample(2).join.capitalize }
      .join
    end
end
