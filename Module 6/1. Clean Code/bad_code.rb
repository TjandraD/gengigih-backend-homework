# save user with auto generated password if user does not give password on registration.
 # default role is temp
 # return error if user email/username/phone is empty.
 def reg_usr(params)
    a = Data.new(params)
    a.role = "admin"
    if a.password.blank?
    a.gen_pass
    end
    raise Error::InvalidUserError if a.email.blank?||a.username.blank?||a.phone.blank?||!(a.email.match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i))||!(a.phone.match(/\A\+?[\d\s\-\.\(\)]+\z/))
    raise Error::DuplicateUser if Data.query("select count(1) from users where phone=#{a.phone} or email=#{a.email}") > 0
    a.save
    a.sendmailcnfrm
    a
end