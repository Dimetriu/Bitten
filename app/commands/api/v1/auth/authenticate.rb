class Api::V1::Auth::Authenticate
  prepend SimpleCommand

  def initialize(given_name:, family_name:, email:, password:)
    @given_name  = given_name
    @family_name = family_name
    @email       = email
    @password    = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private
    attr_reader :email
    attr_accessor :given_name, :family_name, :password

    def user
      user = User.find_by(email: email)
      return user if user && user.authenticate(password)

      errors.add(:authentication, I18n.t("failure.user_not_exist"))
      nil
    end
end
