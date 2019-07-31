require_relative 'application_controller'

class PostsController < ApplicationController

  attr_reader :post

  set :views, File.expand_path('../../views', __FILE__)

  get '/posts' do
    @posts = Post.all
    erb :'post/index'
  end

  # get '/posts/:id' do
  #   @post = Post.find(params[:id])
  # end

  get '/posts/create' do
    erb :'post/new'
  end

  post '/posts/create' do
    post = Post.new(params[:post])
    if post.save
      redirect'/posts'
    else
      redirect '/posts/create'
    end
  end

  private

end
