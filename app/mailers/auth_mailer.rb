class AuthMailer < ApplicationMailer
  default from: "Big Picture Team <#{ENV['MAIL_USER_NAME']}>"

  def login_notificate
    @user = params[:user]
    @request = params[:request]
    @ua = params[:ua]
    res = Geocoder.search(@request.ip)
    @ip_location = res.first.country
    mail to: @user.email, subject: 'Big Picture 로그인 알림'
  #   I18n.t('info.mailers.auth.login_notificate.subject')
  end
end
