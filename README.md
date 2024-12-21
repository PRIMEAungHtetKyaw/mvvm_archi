Todo MVVM Application
A feature-rich Todo application built using Flutter, Firebase, Drift (local database), and Riverpod, implementing MVVM architecture with clean architecture principles.

Features
1. Authentication & Authorization
Email/Password-based user registration and login using Firebase Authentication.
Secure user logout.
Account deletion with reauthentication for security.
2. Task Management
CRUD operations for user-specific todo items stored in Firestore and cached in Drift.
Offline support with local caching and Firestore synchronization.
3. Profile Management
Profile screen displaying user email.
Light/Dark Mode toggle for a personalized user experience.
4. Navigation
Smooth navigation using go_router.
5. Unit Testing
Basic unit tests for repositories and ViewModel logic to ensure reliability.
6. Bonus Features
Account deletion functionality: Securely delete an account and its associated data (both local and remote).
Light/Dark Mode switching: Theme toggle built into the profile screen, reflecting in real-time.


Setup Instructions
Prerequisites
Install Flutter: Flutter Installation.
Firebase Setup:
Create a Firebase project at Firebase Console.
Enable Firebase Authentication and Firestore.
Add your app (iOS/Android) to the Firebase project.
Download and include the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files into your Flutter project.
Add the FlutterFire CLI:
bash
Copy code
dart pub global activate flutterfire_cli
Project Setup
Clone the repository:

bash
Copy code
git clone <your-repository-url>
cd todo_mvvm
Install dependencies:

bash
Copy code
flutter pub get
Configure Firebase:

bash
Copy code
flutterfire configure
Generate code for Riverpod and Drift:

bash
Copy code
flutter pub run build_runner build --delete-conflicting-outputs
Run the app:

bash
Copy code
flutter run

Project Structure
Directories


lib/
├── core/
│   ├── assets/         # App assets (images, lottie animations)
│   ├── router/         # Navigation and routing using go_router
│   ├── theme/          # App theme and theme controller
├── data/
│   ├── local/          # Drift local database implementation
│   ├── repositories/   # Firestore and Drift repositories
├── domain/
│   ├── entities/       # Domain models (e.g., Item, User)
│   ├── repositories/   # Repository interfaces
├── presentation/
│   ├── screens/        # UI screens (e.g., login, register, profile, todo list)
│   ├── widgets/        # Reusable widgets (e.g., custom text fields, dialogs)
├── providers/          # Riverpod providers for various modules
├── viewmodels/         # ViewModels for managing state using Riverpod



Packages Used
Dependencies
Package	Version	Description
firebase_core	^3.9.0	Initialize Firebase in Flutter.
firebase_auth	^5.3.4	Firebase Authentication.
cloud_firestore	^5.6.0	Firebase Cloud Firestore for data storage.
go_router	^14.6.2	Declarative navigation and routing.
riverpod	^2.6.1	State management.
hooks_riverpod	^2.5.1	React hooks for Riverpod.
riverpod_annotation	^2.6.1	Generate providers with annotations.
uuid	^4.5.1	Generate unique IDs for todo items.
drift	^2.22.1	Local database for caching and offline support.
lottie	^3.1.2	Animated illustrations for a better UI experience.
gap	^3.0.1	Adds spacing between widgets.
Dev Dependencies
Package	Version	Description
build_runner	^2.4.10	Code generation for Riverpod and Drift.
drift_dev	^2.22.1	Developer tools for Drift.
mockito	^5.4.4	Unit testing mocks.

Notes
Authentication: Firebase handles secure user authentication and account management.
Data Management:
Drift ensures data availability offline.
Firestore keeps data synchronized when online.
UI/UX:
Users can toggle between Light/Dark Mode.
Account deletion ensures user data (both local and remote) is securely removed.
Testing: Unit tests cover repository and ViewModel logic for reliability.


Features Highlight
Account Deletion:

Secure reauthentication before account deletion.
Deletes all associated todo items (local and remote).
Ensures user data is completely removed from the system.
Light/Dark Mode:

Easily toggle between themes on the Profile screen.
Theme changes reflect instantly across the app.