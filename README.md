# Users List Flutter App

A Flutter application that fetches and displays a list of users from a remote API. The app follows **Clean Architecture** and uses **BLoC state management** for scalable and maintainable code.

---

# Features

- Fetch users from remote API
- Display users in a scrollable list
- Search users by **name, email, or company**
- Pull-to-refresh to reload the list
- User detail screen displaying complete information
- Error handling and loading states
- Offline data handling
- Pagination

---

# Tech Stack

- Flutter
- Dart
- BLoC (State Management)
- Dio (API networking)
- Clean Architecture

---

# Setup Instructions

### 1. Clone the Repository

```
git clone https://github.com/imAdeshMishra/aviara-asignment.git

```

### 2. Install Dependencies

```
flutter pub get
```

### 3. Run the Application

```
flutter run
```

You can run the app on:

- Android Emulator
- iOS Simulator
- Physical Device

---

# API Used

The application uses the public API:

https://jsonplaceholder.typicode.com/users

This API provides mock user data for testing and development.

---

# Packages Used

| Package           | Purpose                      |
| ----------------- | ---------------------------- |
| flutter_bloc      | State management             |
| equatable         | Simplifies object comparison |
| dio               | HTTP client for API calls    |
| shared prefrences | Data Caching                 |

---

# Project Architecture

The project follows **Clean Architecture** with three layers:

```
lib
 ├── core
 │   ├── constants
 │   └── resources
 │   └── di
 │
 ├── features
 │   └── users_list
 │       ├── data
 │       │   ├── data_sources
 │       │   ├── models
 │       │   └── repository
 │       │
 │       ├── domain
 │       │   ├── entities
 │       │   ├── repository
 │       │   └── usecases
 │       │
 │       └── presentation
 │           ├── bloc
 │           └── pages
```

This separation improves **scalability, testability, and maintainability**.

---

# User Detail Screen

When a user is tapped, the detail page displays:

- Name
- Email
- Phone
- Website
- Address

---

# Assumptions Made

- The API response structure will remain consistent.
- Internet connectivity is available when fetching users.
- Only basic error handling is implemented for network failures.
- User search is performed locally on the fetched list.

---

# Author

Adesh Mishra

---
