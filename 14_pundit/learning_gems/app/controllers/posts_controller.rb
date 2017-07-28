class PostsController < ApplicationController

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def index
    @posts = Post.includes(:user)
  end

  def show
    @post = Post.find params[:id]
  end

  def edit
    @post = Post.find params[:id]
    authorize @post
  end

  private
  def pundit_user
    current_user
  end

  def not_authorized
    render plain: 'not authorized', status: 403
  end
end
