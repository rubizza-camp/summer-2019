require 'sinatra/base'

class ApplicationController < Sinatra::Base
  include UserHelper

  set :public_folder, File.realpath('public')
  set :haml, layout: :'../layouts/layout'
  register Sinatra::Flash

  def parameters
    StrongParameters.new(params)
  end
end
