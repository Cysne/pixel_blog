# frozen_string_literal: true

# controller de posts
class PostsController < ApplicationController
  include Pundit::Authorization

  before_action :set_post, only: %i[show edit update destroy]
  # before_action :authenticate_user!, only: %i[new create]
  def index
    if params[:tag]
      @tag = Tag.find_by(name: params[:tag])
      @posts = @tag ? @tag.posts.order(created_at: :desc).page(params[:page]).per(3) : Post.none
    else
      @posts = Post.order(created_at: :desc).page(params[:page]).per(3)
    end
    return unless @posts

    @popular_post = @posts.max_by { |post| post.comment_threads.size }
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
      redirect_to posts_path, alert: 'Post não foi criado com sucesso.'
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
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post foi deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def upload_posts_file
    if params[:file].present?
      file_content = params[:file].read
      PostsCreationJob.perform_async(current_user.id, file_content)
      redirect_to posts_path, notice: 'Arquivo enviado com sucesso.'
    else
      redirect_to posts_path, alert: 'Por favor, selecione um arquivo para enviar.'
    end
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
