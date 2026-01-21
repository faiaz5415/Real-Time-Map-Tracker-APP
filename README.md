# Real-Time Map Tracker 📍

A Flutter application that tracks the user's real-time location on a Google Map. The app automatically animates the camera to follow movement, draws a polyline path of the user's journey, and displays live coordinates via an interactive marker.

## ✨ Features

- **Automatic Map Animation**: The map camera smoothly follows the user's current position.
- **Real-Time Updates**: Fetches and updates the user's location every 10 seconds.
- **Polyline Tracking**: Draws a continuous blue path on the map connecting all previous locations.
- **Interactive Markers**: Displays a marker at the current position with an Info Window showing live Latitude and Longitude.
- **Permission Handling**: Built-in logic to request and verify GPS location permissions.

## 🚀 Getting Started

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest version recommended)
* [Google Maps API Key](https://console.cloud.google.com/)
* Android Studio / VS Code

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/faiaz5415/Google-Map-Integration-APP.git](https://github.com/faiaz5415/Google-Map-Integration-APP.git)
    cd Google-Map-Integration-APP
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Configure API Key:**
    Navigate to `android/app/src/main/AndroidManifest.xml` and replace the API key in the meta-data tag:
    ```xml
    <meta-data 
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_API_KEY_HERE" />
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

## 🛠️ Built With

* [Flutter](https://flutter.dev/) - The framework used.
* [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) - For Map integration.
* [location](https://pub.dev/packages/location) - For fetching GPS coordinates.

## 📝 Configuration Notes

* **Android Permissions**: Ensure `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` are present in your `AndroidManifest.xml`.
* **Billing**: Ensure your Google Cloud Project has an active billing account linked, or the map tiles will appear blank.

---
Developed by [Kh Faiaz Hasan](https://github.com/faiaz5415)