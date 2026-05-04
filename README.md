# LuxeCart — Flutter Bloc Final Project

LuxeCart is a beautiful product discovery mobile application built for the Mobile Application course final project.

## Project requirements

| Requirement | Status |
|---|---|
| Language: Dart | Done |
| Framework: Flutter | Done |
| Bloc state management | Done |
| Request to backend | Done |
| Backend source: DummyJSON | Done |
| Master/List page | Done |
| View/Detail page | Done |
| OOP-style structure | Done |

## Backend API

The application gets real mock data from:

```text
https://dummyjson.com/products
```

## Features

- Product list screen
- Product detail screen
- Search by product, brand, or category
- Category filtering
- Pull-to-refresh
- Loading state
- Error state
- Beautiful modern UI
- Clean layered architecture

## Project structure

```text
lib/
├── core/
│   ├── network/
│   │   └── api_client.dart
│   └── theme/
│       └── app_theme.dart
├── product/
│   ├── data/
│   │   ├── model/
│   │   │   └── product.dart
│   │   └── repository/
│   │       └── product_repository.dart
│   └── presentation/
│       ├── bloc/
│       │   ├── product_bloc.dart
│       │   ├── product_event.dart
│       │   └── product_state.dart
│       ├── pages/
│       │   ├── product_list_page.dart
│       │   └── product_detail_page.dart
│       └── widgets/
│           ├── category_filter.dart
│           ├── hero_header.dart
│           ├── info_pill.dart
│           ├── product_card.dart
│           └── product_search_field.dart
└── main.dart
```

## How to run

```bash
flutter pub get
flutter run
```

To run on a selected device:

```bash
flutter devices
flutter run -d DEVICE_ID
```

## Short defense text

This project is a Flutter mobile application written in Dart. It uses Bloc for state management. The app sends a request to the DummyJSON backend API and displays products received from the server. The main page is a master/list page with search and category filtering. When the user taps a product, the app opens a separate detail/view page with full product information. The code is organized using an OOP-style layered architecture: model, API client, repository, Bloc, pages, and reusable widgets.
