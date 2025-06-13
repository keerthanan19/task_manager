
📝 Personal Task Manager App (Flutter + Firebase + Riverpod)

A personal task management mobile application built with Flutter, using Firebase Authentication,*Cloud Firestore, and Riverpod for state management. Designed following the MVC architecture with clean separation of UI, controllers, and services.


🚀 Features

🔐 Authentication
 Email/Password sign-in
 Registration with form validation
 Auto-login for authenticated users

📋 Task Management
 Create, update, and delete tasks
 Add description, due date, category, and priority
 Mark tasks as complete or pending
 Real-time sync with Firestore

🧠 Task Enhancements
 Filter: All | Pending | Completed
 Search tasks by title
 Priority levels: High, Medium, Low (with color coding)
 Task category tagging
 Sort tasks by due date or priority

🎨 UI/UX
 Responsive design for all screen sizes
 Basic animations and transitions
 Custom Material Design styling

⚙️ Architecture & Tech Stack
 Flutter with Dart
 MVC architecture
 Riverpod for state management
 Firebase (Auth + Firestore)
 Clean and modular codebase

---

📁 Project Structure

```
lib/
├── models/
│   └── task_model.dart
├── views/
│   ├── auth/
│   │   ├── login_view.dart
│   │   └── register_view.dart
│   ├── task/
│   │   ├── task_list_view.dart
│   │   └── task_form_view.dart
│   └── splash_view.dart
├── controllers/
│   ├── auth_controller.dart
│   └── task_controller.dart
├── services/
│   ├── auth_service.dart
│   └── task_service.dart
├── providers/
│   ├── auth_providers.dart
│   └── task_providers.dart
├── widgets/
│   ├── task_card.dart
│   └── filter_chips.dart
├── utils/
│   ├── constants.dart
│   └── validators.dart
└── main.dart
````
---

🔧 Getting Started

✅ Prerequisites

* Flutter SDK (>=3.10)
* Firebase account ([https://console.firebase.google.com](https://console.firebase.google.com))
* Dart extension for your IDE (e.g. VS Code)

---

🛠️ Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Enable **Authentication:

   * Go to **Build → Authentication**
   * Enable **Email/Password** sign-in
3. Setup **Cloud Firestore**:

   * Go to **Build → Firestore Database**
   * Start in **test mode** or set custom security rules (recommended):

     ```js
     rules_version = '2';
     service cloud.firestore {
       match /databases/{database}/documents {
         match /users/{userId}/tasks/{taskId} {
           allow read, write: if request.auth.uid == userId;
         }
       }
     }
     ```
4. Add Android and/or iOS apps to your Firebase project:

   * Android: Add `android/app/google-services.json`
   * iOS: Add `ios/Runner/GoogleService-Info.plist`
5. Make sure you enable Firestore persistence (optional for offline support).

---

## ⚙️ Install Dependencies

```bash
flutter pub get
```

---

## ▶️ Run the App

```bash
flutter run
```

---

## 🧪 Running Tests

Basic widget or unit test examples can be added inside the `test/` directory. Run:

```bash
flutter test
```

---

## 🎯 Future Improvements

* Dark mode / light mode toggle
* Offline storage with local caching
* Task reminders with notifications
* Swipe gestures for quick actions

---

## 📽️ Demo

Screen recording (to be added):
📹 `assets/demo_video.mp4` or provide a link to YouTube/Drive

---

## 🧑‍💻 Author

**Nadaraja Keerthanan**
📧 [kee19n@gmail.com](mailto:kee19n@gmail.com)
🔗 [LinkedIn](https://www.linkedin.com/in/keerthanan-nadaraja-5741aa7a/)
💻 [GitHub](https://github.com/keerthanan19)

---


