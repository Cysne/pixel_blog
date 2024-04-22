class ActionMailerInterceptor
  def self.delivering_email(message)
    message.delivery_method.settings[:domain] = ENV['SMTP_USERNAME'].split('@').last
  end
end
