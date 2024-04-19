# frozen_string_literal: true

# controller de posts
class PostsController < ApplicationController
  include Pundit::Authorization

  before_action :set_post, only: %i[show edit update destroy]
  # before_action :authenticate_user!, only: %i[new create]
  def index
    @posts = Post.page(params[:page]).per(5).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post foi criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post foi atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post = Post.find(params[:id])
    @post.destroyed_by_association
    redirect_to posts_path, notice: 'Post foi deletado com sucesso.'
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
