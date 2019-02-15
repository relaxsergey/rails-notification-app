importScripts('https://www.gstatic.com/firebasejs/5.7.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/5.7.0/firebase-messaging.js');

var config = {
  apiKey: "<%= ENV['API_KEY'] %>",
  authDomain: "<%= ENV['AUTH_DOMAIN'] %>",
  databaseURL: 'https://testpushapp-cf538.firebaseio.com',
  projectId: "<%= ENV['PROJECT_ID'] %>",
  storageBucket: "<%= ENV['STORAGE_BUCKET'] %>",
  messagingSenderId: "<%= ENV['FCM_ID'] %>"
};
firebase.initializeApp(config);
var messaging = firebase.messaging();

// If you would like to customize notifications that are received in the
// background (Web app is closed or not in browser focus) then you should
// implement this optional method.
// [START background_handler]
messaging.setBackgroundMessageHandler(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  var notificationTitle = payload.data.title;
  var url = payload.data.click_action;
  var notificationOptions = {
    body: payload.data.body,
    icon: payload.data.icon,
    data: { link: payload.data.click_action }
  };
  return self.registration.showNotification(notificationTitle,
    notificationOptions);
});
// [END background_handler]

// click web push notification event
self.addEventListener('notificationclick', function(event) {
  const target = event.notification.data.link || '/';
  event.notification.close();
  // This looks to see if the current is already open and focuses if it is
  event.waitUntil(clients.matchAll({
    type: 'window',
    includeUncontrolled: true
  }).then(function(clientList) {
    // clientList always is empty?!
    for (var i = 0; i < clientList.length; i++) {
      var client = clientList[i];
      if (client.url === target && 'focus' in client) {
        return client.focus();
      }
    }

    return clients.openWindow(target);
  }));
});
