# Srisawad Mobile Application

This is a cross-platform mobile application built using the Flutter framework.

## Release

- update 2022-11-24 version v.0.0.3
  - fixed ui in introduction page
  - fixed login hardcode
  - fixed otp page widget
  - save topup and add choose image from gallery option
  - new popup image
  - fixed register function
  - fixed hardcode along ui and clean unuse print
  - git wrong name v.0.0.4 = v.1.0.22+23 is v.0.0.3

## What is This ?

---

This project is a starting point for a Flutter application for Srisawad users.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Prerequisite for Application

1. GCP service setup (firebase storage, firestore, messaging, Firebase analytic, Crashlytic and authentication )
2. Firebase Anaytlics
3. An Apple developer account.
4. An Google console developer account.
5. Assets Image Folder (from Customer or Our UX/UI or Designer Image)
6. Xcode and android studio for Emulator (must install first )
7. Package Dependencies flutter.
8. Flutter 3.3.10
9. Create Android app to Firebase project
   1. Go to the Firebase Console and create a new project if you haven't already.
   2. Add a new Android app to your project and follow the setup instructions.
   3. Download the **google-services.json** file and add it to the android/app directory of your project.
10. Create IOS app to Firebase project
    1. Go to the Firebase Console and create a new project if you haven't already.
    2. Add a new IOS app to your project and follow the setup instructions.
    3. Download the **GoogleService-Info.plist** file and add it to the ios/Runner directory of your project.

---

## Getting Started

1. Install Flutter by following the instructions on the official Flutter website.
2. Clone this repository to your local machine.

   - DEV : https://source.cloud.google.com/magnetic-guild-359002/srisawad-mobile-application-ui
   - UAT : https://source.cloud.google.com/srisawad-mobile-app-qa-360402/srisawad-mobile-application-ui
   - PROD : https://source.cloud.google.com/srisawad-mobile-app-prd/srisawad-mobile-application-ui

3. Run flutter pub get to install the necessary packages.
   ```
   flutter clean
   flutter pub get
   ```
4. Set up Firebase Cloud Messaging for both Android and iOS .
   1. Set up the Cloud Messaging settings.On “Firebase page” > “Project settings” > “Cloud messaging”
      - Firebase Cloud Messaging API should “Enabled”
      - Cloud Messaging API should “Enabled”
   2. Setup [“Apple app configuration”](https://firebase.flutter.dev/docs/messaging/apple-integration/).You must configure the APNs key for Apple apps to use Firebase messaging for authentication on an iOS device.
      - Require: APNs cert file(.p8)
5. Set up environment variable(.env) file.
   - **SRISAWAD_APP_DEPLOYED_DEV** : Backend Url
   - **IMAGE_LOCATION** : Firebase storage bucket to store user image
6. Set up Android and IOS platform config file.
   - "/android/app/google-services.json" : Android google configuration
   - "/ios/Runner/GoogleService-Info.plist" : IOS google configuration
7. Setup Firebase options configuration file
   - "/lib/firebase_options.dart" : Firebase configuration
8. Install the firebase CLI
   ```
        dart pub global activate flutterfire_cli
   ```
   Run the `configure` command, select a Firebase project and platforms
   ```
   flutterfire configure
   ```

# Development Note

#### Testing on your local machine

- run with flutter run
  ```
  flutter run
  ```

---

### Build Android app (Deploy)

You may have to setup the sign-key for android application(/android/key.properties) then update **"storeFile"** field to point on **"upload-keystore.jks"** file

- Build Android apk file
  ```
  flutter build apk
  ```
- Build Android appbundle file
  ```
  flutter build appbundle
  ```

---

### Build IOS app(Deploy)

You may have to setup xcode and IOS configuration file

1.  Install pod dependencies, Go into **"ios"** folder then execute below command.
    ```
    pod install
    ```
2.  Go to **"xcode"** then select "product" > "archive" on "any IOS device arm64"
