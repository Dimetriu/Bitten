class Api::V1::Auth::AuthenticateSubject
  prepend SimpleCommand

  def initialize(email, password)
    @email    = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  rescue NameError
    I18n.t('user.already_signed_in')
  end

  private
    attr_reader :email, :password

    def user
      user = User.find_by(email: email)
      return user if user && user.authenticate(password)

      errors.add(:authentication, I18n.t('failure.user_not_exist'))
      nil
    end
end
