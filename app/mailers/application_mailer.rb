# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "noreply@cinemashelf.com"
  layout "mailer"
end
