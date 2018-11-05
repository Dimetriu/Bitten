class Api::V1::Urls::ShortenUrl
  prepend SimpleCommand

  def initialize(owner, body)
    @owner = owner
    @body  = Api::V1::Urls::ShortenUrl.normalize(body)
  end

  def self.normalize(body)
    uri = URI(body)
    uri = URI('http://' << uri.to_s).to_s if uri.scheme.nil?
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
      (
        ('A'..'z').to_a.keep_if { |i| /\w/.match(i) }.sample(3)
        +
        (1..3).collect { rand(9) }
      )
      .join
    end
end
