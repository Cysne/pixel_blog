class Post::UploadPostsFile < Micro::Case
  attributes :file, :user_id

  def call!
    dir_path = Rails.root.join('tmp', 'uploads')
    FileUtils.mkdir_p(dir_path) unless Dir.exist?(dir_path)

    file_path = dir_path.join(file.original_filename)

    File.open(file_path, 'wb') do |f|
      f.write(file.read)
    end

    PostsCreationJob.perform_async(user_id, file_path.to_s)

    Success result: { message: 'Arquivo enviado com sucesso' }
  end
end
