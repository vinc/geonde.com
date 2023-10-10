class SubscriberMailer < ApplicationMailer
  # Notify the admins when someone subscribe
  # TODO: Replace that with a daily summary
  def notification_email
    @subscriber = params[:subscriber]
    mail(to: "admin@geonde.com", subject: "[Geonde] New subscriber")
  end
end
