class UserWrongPasswordOrEmailError < RuntimeError
end

class UserEmailOccupiedError < RuntimeError
end

class UserPasswordNotMatchError < RuntimeError
end
