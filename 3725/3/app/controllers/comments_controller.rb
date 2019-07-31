require_relative 'application_controller'

class CommentsController < Sinatra::Base

  def new
    @comment = Comment.new
  end

end
