// web/firebase-messaging-sw.js

// ✅ Import Firebase libraries (compat versions for messaging)
importScripts("https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.1/firebase-messaging-compat.js");

// ✅ Initialize Firebase
firebase.initializeApp({
    apiKey: "AIzaSyDGAXUAqYtEHIqWvnyRRo-VblFma60_-dk",
      authDomain: "taskmanagement-a9ad6.firebaseapp.com",
      projectId: "taskmanagement-a9ad6",
      storageBucket: "taskmanagement-a9ad6.firebasestorage.app",
      messagingSenderId: "64476021204",
      appId: "1:64476021204:web:aa45a2efd3794c45ead641",
      measurementId: "G-GZFV7TD2VR",
});

// ✅ Get messaging instance
const messaging = firebase.messaging();

// ✅ Handle background messages
messaging.onBackgroundMessage((payload) => {
  console.log("🔕 Background message received:", payload);

  const notificationTitle = payload.notification.title || "📢 Notification";
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/icon-192.png', // optional: your app icon path
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
