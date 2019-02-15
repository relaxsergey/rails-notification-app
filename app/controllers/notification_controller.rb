class NotificationController < ApplicationController
  def subscribe
    User.find_or_create_by(subscribe_token: params[:subscription], server_name: 'FCM')

    head :ok
  end

  def unsubscribe
    # TODO: чекнуть подписаных узеров на сервере FCM и
    # TODO: сравнить с теми что есть в ДБ приложения.
    # TODO: удалить с БД лишних юзеров. (хз как это сделать)
    # TODO: или слать уведомления всем кто есть в БД.
    # TODO: сервак FCM сам разберется кому слать уведомление))
    # TODO: сделать отписку но хз как...
  end

  def push
    Rails.logger.info "Sending push notification..."
    User.find_each do |user|
      NotificationJob.perform_later(user.subscribe_token)
    end

    head :ok
  end
end
