# frozen_string_literal: true

# controller de comentarios
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment_params = params.require(:comment).permit(:body)
    comment_params.merge!(user_id: current_user.id) if current_user
    @comment = @post.comment_threads.build(comment_params)
    if @comment.save
      redirect_to root_path, notice: 'Comentario Postado com sucesso'
    else
      redirect_to root_path, alert: 'Erro ao Criar Comentario'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
