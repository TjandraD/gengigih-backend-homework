def register_user(params)
    user = User.new(params)
    user.role = "admin"

    user.gen_pass if user.password.blank?

    raise Error::InvalidUserError if user.invalid?
    raise Error::DuplicateUser if user.duplicate?

    user.save
    user.send_email_confirmation
    user
end