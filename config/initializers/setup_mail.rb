ActionMailer::Base.smtp_settings = {
    port:           ENV['SENDGRID_PORT'],
    address:        ENV['SENDGRID_ADRESS'],
    user_name:      ENV['SENDGRID_USERNAME'],
    password:       ENV['SENDGRID_PASSWORD'],
    domain:         ENV['SENDGRID_DOMAIN'],
    authentication: :login,
    enable_starttls_auto: true
}
ActionMailer::Base.delivery_method = :smtp