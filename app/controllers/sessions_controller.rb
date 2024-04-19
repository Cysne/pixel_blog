# frozen_string_literal: true

# controller de sessões
class SessionsController < Devise::SessionsController
  def create
    super
    return unless current_user

    current_user.update_attribute(:last_sign_in_at, Time.now)
  end
end
