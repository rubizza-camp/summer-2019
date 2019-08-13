# :reek:NilCheck
module EmailShower
  def self.call(session)
    User.find_by(id: session['warden.user.default.key'])&.email
  end
end
