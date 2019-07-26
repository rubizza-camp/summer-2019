#!/bin/env ruby

require './environment'
require './app'

use Warden::Manager do |config|
  config.serialize_into_session(&:id)
  config.serialize_from_session { |id| User.first(id: id) }

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
    params['user'] && params['user']['useremail'] && params['user']['password']
  end

  def authenticate!
    user = User.first(useremail: params['user']['useremail'])

    if user.nil?
      throw(:warden, message: 'The useremail you entered does not exist.')
    elsif user.authenticate(params['user']['password'])
      success!(user)
    else
      throw(:warden, message: 'The useremail and password combination ')
    end
  end
end

run Sinatra::Application
