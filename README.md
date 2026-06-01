# Smart Idly Kadai App 🌾🔥

A beautiful, professional Flutter mobile application built with **Flutter**, **Provider**, and **Firebase Mock Live Synced Service**.

This application demonstrates a premium user interface with a real-time synchronized menu and shop open/closed status. Changes made by the owner in the **Admin Dashboard** reflect **instantly** in the customer menu and homepage.

---

## 🚀 How to Run in VS Code

1. **Generate Platform Folders (Android/iOS/Web):**
   - Since this codebase contains only the Flutter source files (`lib/` and `pubspec.yaml`), you must generate the platform-specific folders first.
   - Open a terminal in the project directory (`C:\Users\ACER\.gemini\antigravity\scratch\smart_idly_kadai`) and run:
     ```bash
     flutter create .
     ```
   - This will automatically generate the `android/`, `ios/`, and `web/` folders matching your local Flutter SDK version.

2. **Get Packages:**
   - Run the following command in the terminal:
     ```bash
     flutter pub get
     ```

3. **Launch the App:**
   - Select a device/emulator from the VS Code status bar (bottom right).
   - Press `F5` or click **Run -> Start Debugging** to compile and run the app.

---

> [!TIP]
> **Setting up Flutter SDK PATH:**
> If `flutter` is not recognized, make sure you have extracted your Flutter SDK (e.g. from `C:\Users\ACER\dev\flutter_windows_stable.zip`) to a permanent folder (like `C:\src\flutter`) and added `C:\src\flutter\bin` to your User **Environment Variables (PATH)**.

---

## 🛠️ Architecture and Files

- **`lib/main.dart`**: Entry point of the application, configuring global Providers and custom App Theme (modern South Indian design style).
- **`lib/models/dish.dart`**: The structured data representation of a Menu Item, including categories and side dishes.
- **`lib/services/firebase_service.dart`**: The mock Firebase Firestore service. It acts exactly like a Firestore database by streaming data, making it 100% plug-and-play ready for real Firebase.
- **`lib/providers/menu_provider.dart`**: Manages app state, search queries, filtering by category (All, Breakfast, Lunch, Dinner), and handles updates between Customer and Admin dashboards.
- **`lib/screens/`**:
  - `main_navigation_screen.dart`: Bottom Navigation management.
  - `home_screen.dart`: Beautiful home page with active status banner and specials.
  - `menu_screen.dart`: Searchable and filterable menu list with beautiful empty states.
  - `dish_details_screen.dart`: Displays price, detailed description, and side dish chips.
  - `admin_dashboard.dart`: Live tools for adding, editing, deleting dishes, and changing shop status.
  - `project_info_screen.dart`: Technical summary of the project setup.

---

## 🔥 Transitioning to Production Firebase

To link the mock streams to real Firebase:
1. Initialize Firebase in your project using `flutterfire configure`.
2. Add `firebase_core` and `cloud_firestore` to `pubspec.yaml`.
3. In `lib/services/firebase_service.dart`, replace the mock streams with live Firestore collection references:
   ```dart
   // Example replacement:
   Stream<List<Dish>> getDishesStream() {
     return FirebaseFirestore.instance
         .collection('dishes')
         .snapshots()
         .map((snapshot) => snapshot.docs.map((doc) => Dish.fromFirestore(doc)).toList());
   }
   ```
git clone https://github.com/RajamuruganK07/smart-idly-kadai.git,

cd smart-idly-kadai,

flutter pub get,

flutter run -d chrome
