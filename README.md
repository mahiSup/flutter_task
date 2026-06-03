# GitHub User Explorer

A production-ready Flutter application that allows users to browse GitHub profiles, search users, view detailed profile information, and manage favorite users locally.

This project was developed using **Clean Architecture**, **BLoC State Management**, and follows scalable Flutter development practices.

---

# Features

## Home Screen

* Display GitHub users from GitHub API
* Pull-to-refresh support
* Search users with debounced API calls
* Loading, Empty, and Error states
* Add users to Favorites
* Responsive UI

## User Details Screen

* User profile image
* Username
* Bio
* Followers count
* Following count
* Public repositories count
* Full-screen profile image preview with zoom support

## Favorites Screen

* View saved favorite users
* Remove favorite users
* Confirmation dialog before removal
* Persistent local storage

## Additional Features

* Clean Architecture
* BLoC State Management
* Dependency Injection using GetIt
* Dio Network Layer
* Retry Mechanism
* Internet Connectivity Handling
* Shimmer Loading UI
* Search with Debounce
* Unit Tests
* Widget Tests
* High Test Coverage

---

# Tech Stack

* Flutter
* Dart
* flutter_bloc
* dio
* get_it
* dartz
* connectivity_plus
* hive
* cached_network_image
* photo_view
* shimmer
* mocktail
* bloc_test
* flutter_test

---

# Project Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── utils/
│   └── widgets/
│
├── features/
│   └── users/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
├── injection_container.dart
└── main.dart
```

---

# Architecture Overview

The application follows Clean Architecture principles and is divided into three layers.

## 1. Presentation Layer

Responsible for UI rendering and state management.

Components:

* Pages
* Widgets
* BLoCs
* Events
* States

Examples:

```text
UsersBloc
FavoritesBloc
UserDetailBloc
```

Responsibilities:

* UI rendering
* User interactions
* State management
* Navigation

---

## 2. Domain Layer

Contains business rules and application logic.

Components:

```text
Entities
Repositories (Contracts)
Use Cases
```

Examples:

```text
GetUsers
GetUserDetails
SearchUsers
SaveFavorite
RemoveFavorite
GetFavorites
```

Responsibilities:

* Business logic
* Application rules
* Independent of Flutter framework

---

## 3. Data Layer

Handles data retrieval and storage.

Components:

```text
Remote Data Sources
Local Data Sources
Repository Implementations
Models
```

Responsibilities:

* API communication
* Local persistence
* Data mapping

---

# Data Flow

```text
UI
 ↓
Bloc
 ↓
UseCase
 ↓
Repository
 ↓
Datasource
 ↓
API / Local Database
```

Response Flow:

```text
API / Local Database
 ↓
Datasource
 ↓
Repository
 ↓
UseCase
 ↓
Bloc
 ↓
UI
```

---

# State Management

The project uses BLoC pattern.

Example:

```text
LoadUsersEvent
        ↓
UsersBloc
        ↓
UsersLoading
        ↓
UsersLoaded
```

States handled:

* Initial
* Loading
* Success
* Empty
* Error

---

# Local Storage

Favorites are persisted using local storage.

Stored Data:

```text
User ID
Username
Avatar URL
Profile URL
```

Favorites remain available after app restart.

---

# Network Handling

Implemented features:

* Internet connectivity check
* Retry interceptor
* Timeout handling
* API error parsing
* Graceful offline support

Possible failures handled:

```text
No Internet
Connection Timeout
Server Error
Unexpected Error
```

---

# Search Implementation

Implemented using:

```text
BLoC + Debounce
```

Behavior:

* API call delayed by 500ms
* Prevents unnecessary requests
* Improves performance
* Reduces GitHub API usage

---

# Testing

Implemented:

## Unit Tests

Coverage includes:

* Use Cases
* Repository Layer
* BLoCs
* Error Handling

## Widget Tests

Coverage includes:

* Users Screen
* Details Screen
* Favorites Screen
* Loading State
* Empty State
* Error State

---

# Setup Instructions

## Prerequisites

Install:

* Flutter SDK (Latest Stable)
* Android Studio / VS Code
* Xcode (for iOS)

Verify installation:

```bash
flutter doctor
```

---

## Clone Repository

```bash
git clone <repository-url>
```

Navigate to project:

```bash
cd github_user_explorer
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Generate Files (if applicable)

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

---

## Run Application

Android:

```bash
flutter run
```

iOS:

```bash
flutter run
```

---

## Run Tests

Unit Tests:

```bash
flutter test
```

Coverage:

```bash
flutter test --coverage
```

Generate HTML report:

```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

# Assumptions

The following assumptions were made during development:

1. GitHub API does not require authentication for the assignment scope.
2. Search functionality uses GitHub public search endpoint.
3. Favorites are stored locally and not synced to GitHub.
4. User profile details are fetched on-demand.
5. Network availability is checked before API requests.

---

# Future Improvements

Given additional time, the following enhancements can be implemented:

## Offline Support

* Cache users list
* Cache user details
* Offline-first architecture

---

## Pagination

Implement GitHub API pagination for:

* Users list
* Search results

---

## Dark Mode

Add:

```text
Light Theme
Dark Theme
System Theme
```

---

## Analytics

Track:

* Search usage
* Favorites usage
* Screen navigation

---

## Advanced Search

Filters:

* Location
* Repository count
* Followers count

---

## CI/CD

Automate:

* Build
* Test
* Lint
* Deploy

Using:

* GitHub Actions
* Codemagic
* Fastlane

---

# Code Quality Practices

* Clean Architecture
* SOLID Principles
* Dependency Injection
* Separation of Concerns
* Reusable Widgets
* Feature-Based Folder Structure
* Testable Code
* Production-Ready Error Handling

---

# Assignment Requirements Checklist

✅ Clean Architecture

✅ BLoC State Management

✅ GitHub Users API Integration

✅ User Details Screen

✅ Favorites Persistence

✅ Search Users

✅ Debounced Search

✅ Pull To Refresh

✅ Loading States

✅ Empty States

✅ Error States

✅ Offline Handling

✅ Retry Mechanism

✅ Shimmer Loading UI

✅ Unit Tests

✅ Widget Tests

✅ Responsive UI

✅ Production Quality Code

---

# Author

Mahendra Yadav

Flutter Developer

