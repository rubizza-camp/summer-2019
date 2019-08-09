require_relative 'application_controller'

class RegistrationsController < ApplicationController
  get '/sign_up' do
    erb :sign_up
  end
end
