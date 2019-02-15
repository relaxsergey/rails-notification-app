require 'shellwords'

module Notification
  def push_notification(alert)
    firebase_key = ENV['FCM_KEY']
    firebaseApi = "curl -X POST --header 'Authorization: key=#{firebase_key}' --Header 'Content-Type: application/json' https://fcm.googleapis.com/fcm/send -d "
    alert_title = 'test test'
    alert_description = 'pidar pidar'

    #Notification params for Mobile
    # notificationParams = {
    #   notification: {
    #     body: alert_description,
    #     title: alert_title,
    #     sound: 'default',
    #     click_action: 'FCM_PLUGIN_ACTIVITY',
    #     icon: 'fcm_push_icon',
    #     content_available: true
    #   },
    #   data: {
    #     title: alert_title,
    #     body: alert_description,
    #     click_action: 'FCM_PLUGIN_ACTIVITY',
    #     icon: 'fcm_push_icon'
    #   },
    #   priority: "high"
    # }


    #Notification params for web
    notificationParamsWeb = {
      notification: {
        body: alert_description,
        title: alert_title,
        icon: '/images/logo.png'
      }
    }

    # notificationTopicAndroid = {
    #   to: '/topics/firebase-android'
    # }
    # notificationTopicIos = {
    #   to: '/topics/firebase-ios'
    # }
    notificationTopicWeb = {
      to: '/'
    }

    # requestAndroid = notificationParams.merge(notificationTopicAndroid).to_json
    # requestIos = notificationParams.merge(notificationTopicIos).to_json
    requestWeb = notificationParamsWeb.merge(notificationTopicWeb).to_json
    # system("#{firebaseApi} #{Shellwords.escape(requestAndroid)}")
    # system("#{firebaseApi} #{Shellwords.escape(requestIos)}")
    system("#{firebaseApi} #{Shellwords.escape(requestWeb)}")
  end
end
