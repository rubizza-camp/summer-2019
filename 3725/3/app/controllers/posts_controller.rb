class PostsController < ApplicationController

  attr_reader :post

  get '/all' do
    @posts = Post.all
    erb :'posts/posts.html'
  end

  get '/all/:id' do
    @post = Post.find_by(id: params[:id])
    session[:id] = @post.id
    erb :'posts/show.html'
  end

  get '/new' do
    erb :'posts/new.html'
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
