class Api::V1::Auth::RegisterSubject
  prepend SimpleCommand

  def initialize(given_name, family_name, email, password, password_confirmation)
    @given_name            = given_name
    @family_name           = family_name
    @email                 = email
    @password              = password
    @password_confirmation = password_confirmation
  end

  def call
    return user.save if user.valid?

    errors.add(:user, I18n.t('user.cant_save_user'))
    rescue ActiveRecord::RecordNotUnique
      I18n.t('user.already_exists')
  end

  private
    attr_reader :email
    attr_accessor :given_name, :family_name, :password, :password_confirmation

    def user
      User.new(
        given_name,
        family_name,
        email,
        password,
        password_confirmation
      )
    end
end
