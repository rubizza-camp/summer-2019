require 'bundler/setup'

Bundler.require

Dir.glob('./app/{models,helpers,controllers}/*.rb').each { |file| require file }

map('/posts') { run PostsController }
map('/reviews') { run ReviewsController }
map('/users') { run UsersController }
run ApplicationController
