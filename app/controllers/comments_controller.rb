# frozen_string_literal: true

# controller de comentarios
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      redirect_to @post, notice: 'Comentario Criado Com Sucesso'
    else
      redirect_to @post, alert: 'Erro ao Criar Comentario'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
