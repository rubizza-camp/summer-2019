class PostsController < ApplicationController
  attr_reader :post

  get '/all' do
    @posts = Post.all
    erb :'posts/posts'
  end

  get '/all/:id' do
    @post = Post.find_by(id: params[:id])
    session[:id] = @post.id
    erb :'posts/show'
  end

  get '/new' do
    erb :'posts/new'
  end

  post '/' do
    post = Post.new(params[:post])
    if post.save
      redirect 'posts/all'
    else
      redirect 'posts/new'
    end
  end
end
