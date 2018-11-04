class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[:attribute] << (options[:message] || I18n.t('url.invalid_url') unless url_valid?(value))
  end

  def url_valid?(value)
    url = URI.parse(value) rescue false
    url.is_a?(URI::HTTP || URI::HTTPS)
  end
end
