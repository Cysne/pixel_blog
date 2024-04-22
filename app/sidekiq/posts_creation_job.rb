class PostsCreationJob
  include Sidekiq::Worker

  def perform(user_id, file_path)
    user = User.find(user_id)
    Rails.logger.info 'Iniciando a criação do post'

    File.open(file_path, 'r').each_line do |line|
      title, content, tags = line.strip.split('|')
      post = user.posts.build(title:, content:)

      tags.split(',').each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name.strip)
        post.tags << tag
      end

      if post.save
        Rails.logger.info "Post criado com sucesso: #{post.title}"
      else
        Rails.logger.error "Falha na criação do post: #{post.errors.full_messages.join(', ')}"
      end
    end
  end
end