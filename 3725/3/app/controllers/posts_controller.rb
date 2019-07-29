class PostsController < ApplicationController

  get '/' do
    @posts = Post.all
    haml :posts
  end

  get '/:id' do
    @post = Post.find(params[:id])
  end

end
