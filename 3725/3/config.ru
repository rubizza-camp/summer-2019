require 'bundler/setup'

Bundler.require

Dir.glob('./app/{models,helpers,controllers}/*.rb').each { |file| require file }
# Sinatra::Base.set public_folder: proc { File.join(__FILE__, './public/') }

map('/posts') { run PostsController }
map('/reviews') { run ReviewsController }
map('/users') { run UsersController }
run ApplicationController
