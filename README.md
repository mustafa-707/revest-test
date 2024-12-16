
# Revest Test App

This is a Flutter application that displays products from the [DummyJSON API](https://dummyjson.com/docs/products) with offline support using SQLite (`drift db`). The app follows the MVVM pattern and uses **Riverpod** for state management.

## Features

- **Product Listing**: Displays product title, description, and image.
- **Product Details**: Includes product images, title, description, rating, category, and price.
- **Offline Support**: Stores product data in SQLite for offline usage.
- **State Management**: Uses **Riverpod** for state management.

## Tech Stack

- **Flutter**: Framework for building the app `v3.27.0`.
- **Riverpod**: State management.
- **drift**: Local SQLite database for offline support.
- **CachedNetworkImage**: Efficient image loading and caching [Pub.dev](https://pub.dev/packages/visibility_cached_image).

## Installation

1. Clone the repo:

   ```bash
   git clone https://github.com/mustafa-707/revest-test.git
   cd revest-test
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run --dart-define ENV=dev
   ```
