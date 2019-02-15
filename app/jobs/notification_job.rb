class NotificationJob < ActiveJob::Base
  queue_as :default

  def perform(token)
    client = NotificationClient.new(token).send_notification

    log("sending POST request to FCM server")
    log("success") if client["success"] == 1
    log("failure") if client["failure"] == 1
    log(client)
  end

  def log(message)
    Rails.logger.info("[NotificationClient] || #{message}")
  end
end
