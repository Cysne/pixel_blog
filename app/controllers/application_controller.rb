class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def download_model
    send_file(
      "#{Rails.root}/public/model.txt",
      filename: 'model.txt',
      type: 'application/txt'
    )
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nome username avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nome username avatar])
  end
end
