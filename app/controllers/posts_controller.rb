# frozen_string_literal: true

# controller de posts
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  # before_action :authenticate_user!, only: %i[new create]
  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    debugger
    if @post.save
      redirect_to @post, notice: 'Post foi criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post foi atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, status: :see_other, notice: 'Post foi deletado com sucesso.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    if params[:post][:tag_ids].is_a?(Array)
      tag_ids = params[:post][:tag_ids].reject(&:empty?).map(&:to_i)
      params[:post][:tag_ids] = tag_ids
    end
    params.require(:post).permit(:title, :content, :image, tag_ids: [])
  end
end
