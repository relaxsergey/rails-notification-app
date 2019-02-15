# frozen_string_literal: true

# NotificationClient
class NotificationClient
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def send_notification
    HTTParty.post(host, body: query, headers: headers)
  end

  private

  def query
    @query ||= { data: { title: 'Test Title',
                         body: 'Test Body',
                         icon: 'https://peter-gribanov.github.io/serviceworker/Bubble-Nebula.jpg',
                         click_action: 'https://www.nasa.gov/feature/goddard/2016/hubble-sees-a-star-inflating-a-giant-bubble' },
                 to: token }
    @query.to_json
  end

  def host
    @host ||= 'https://fcm.googleapis.com/fcm/send'
  end

  def headers
    @headers ||= { "Content-Type" => "application/json",
                   "Authorization" => authorization }
  end

  def fcm_key
    @fcm_key ||= ENV['FCM_KEY']
  end

  def authorization
    @authorization ||= 'key=' + fcm_key
  end
end
