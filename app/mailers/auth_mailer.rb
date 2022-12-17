class AuthMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def login_notificate
    @user = params[:user]
    @request = params[:request]
    mail to: @user.email, subject: 'Big Picture 로그인 알림'
  #   I18n.t('info.mailers.auth.login_notificate.subject')
  end
end
