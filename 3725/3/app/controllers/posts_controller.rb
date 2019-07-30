require 'sinatra/base'
require 'sinatra'

class PostsController < ApplicationController

  get '/posts' do
    @posts = Post.all
    erb :'post/index'
  end

  get '/:id' do
    @post = Post.find(params[:id])
  end

end
