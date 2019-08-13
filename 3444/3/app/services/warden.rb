# :reek:MissingSafeMethod and :reek:NilCheck
class ApplicationController < Sinatra::Base
  use Warden::Manager do |config|
    config.serialize_into_session(&:id)
    config.serialize_from_session { |id| User.find(id) }

    config.scope_defaults :default,
                          strategies: [:password],
                          action: 'auth/unauthenticated'
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env, _opts|
    env['REQUEST_METHOD'] = 'POST'
    env.each do |key, _value|
      env[key]['_method'] = 'post' if key == 'rack.request.form_hash'
    end
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['user'] && params.dig('user', 'email') && params.dig('user', 'password')
    end

    def authenticate!
      user = User.find_by(email: params.dig('user', 'email'))
      throw(:warden, message: 'The email you entered does not exist.') unless user

      if user.authenticate(params['user']['password'])
        success!(user)
      else
        throw(:warden, message: 'The email and password combination ')
      end
    end
  end
end
