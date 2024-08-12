# Flutter Notes App (Android)

This Flutter project is a learning application developed during the course of completing the [Lab: "Free Flutter Course (Full Flutter Course for Beginners)"](https://www.youtube.com/playlist?list=PL6yRaaP0WPkVtoeNIGqILtRAgd3h2CNpT).
It showcases a robust note-taking application integrated with SQLite, Firebase Authentication, and Cloud Firestore. 
Users can register and log in securely using their email and password, complete with email verification. 
Key features include creating, editing, deleting notes, and sharing them via the share_plus package.

## Overview:

![A screenshot showing app](/assets/desc_screenshots/Screenshot_hor.png)

## Features:

- **User Authentication:** Secure user registration and login using Firebase Authentication with email & password.
- **Email Verification:** Verify user email.
- **Note Management:** Create, edit, and delete notes.
- **Cloud Sync:** Sync notes across devices using Cloud Firestore to ensure data consistency.
- **Note Sharing:** Share notes seamlessly with others through the share_plus package.

## Technologies Used:

- **Flutter:** Framework for building cross-platform applications.
- **SQLite:** Local database for storing notes locally on the device.
- **Firebase:** Backend services for authentication and cloud storage.
  - **Firebase Authentication:** User authentication and verification
  - **Cloud Firestore:** Cloud-hosted NoSQL database for syncing notes.
- **Bloc:** State management architecture for maintaining application state.

## Getting Started

To run the project locally, ensure you have Flutter installed. 
Clone the repository and run flutter run in your terminal to launch the application on your preferred device or emulator.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.