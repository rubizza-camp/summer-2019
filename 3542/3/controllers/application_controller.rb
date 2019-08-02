require 'sinatra/base'

class ApplicationController < Sinatra::Base
  include UserHelper

  before do
    return if request.path_info == '/login'
    return if request.path_info == '/signup'
    return if request.path_info == '/logout'

    redirect '/login' unless login?
  end

  set :public_folder, File.realpath('public')
  set :haml, layout: :'../layouts/layout'
  register Sinatra::Flash

  def parameters
    StrongParameters.new(params)
  end
end
