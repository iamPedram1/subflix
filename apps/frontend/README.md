<div align="center">

# 🎬 SubFlix

**A premium AI subtitle translation app built with Flutter.**

Search for movies and series, fetch mocked English subtitle sources, upload your own subtitle files, translate them into your preferred language, preview the result, and export polished subtitle files with a premium mobile UX.

<br/>

![Flutter](https://img.shields.io/badge/Flutter-3.41+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.11+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-Codegen%20State%20Management-00B3E6?style=for-the-badge)
![GoRouter](https://img.shields.io/badge/go_router-Navigation-5B5BD6?style=for-the-badge)
![Freezed](https://img.shields.io/badge/Freezed-Immutable%20Models-8A2BE2?style=for-the-badge)
![License](https://img.shields.io/badge/License-Private-red?style=for-the-badge)

</div>

---

## ✨ Features

|  | Feature | Description |
|---|---|---|
| 🚀 | **Onboarding** | Premium 3-step onboarding flow introducing search, upload, translation, and export paths. |
| 🏠 | **Home Dashboard** | Hero section, quick actions, recent translation jobs, and trust indicators. |
| 🔎 | **Search Flow** | Debounced movie and series search with mocked subtitle source discovery. |
| 🌍 | **Translation Setup** | Select a target language and launch a mocked translation pipeline with progress states. |
| 📂 | **Upload Flow** | Import local `.srt` and `.vtt` files or use a built-in demo subtitle file. |
| 👀 | **Preview** | Review subtitles in original, translated, or bilingual mode with in-preview search. |
| 📚 | **History** | Reopen previous translation jobs from local history. |
| ⚙️ | **Settings** | Preferred language, theme mode, legal placeholders, premium placeholder, and cache clearing. |
| 📤 | **Export** | Save translated subtitle files locally in the proper subtitle format. |

---

## 🛠️ Tech Stack

| Category | Libraries |
|---|---|
| 🏗️ **Framework** | Flutter 3.41+ · Dart 3.11+ |
| 🧠 **State Management** | Riverpod · `riverpod_annotation` · `riverpod_generator` |
| 🧭 **Routing** | `go_router` · `go_router_builder` |
| 🧊 **Models** | Freezed · `json_serializable` |
| 🌐 **Networking Seam** | Dio |
| 💾 **Local Storage** | SharedPreferences |
| 📁 **File Handling** | `file_picker` · `path_provider` |
| 🎞️ **UI / Motion** | `flutter_animate` · `google_fonts` |
| 🧪 **Testing** | `flutter_test` · Riverpod containers · `mocktail` |

---

## 📂 Project Structure

```text
lib/
├── 🏛️ core/
│   ├── app/           # App root, routing, bootstrap
│   ├── providers/     # Shared repository and service providers
│   ├── styles/        # Theme, colors, radii
│   ├── ui/            # Reusable widgets and icon aliases
│   ├── utils/         # Parsers, formatters, helpers
│   └── extensions/    # Shared formatting extensions
│
└── 🧩 features/
    ├── onboarding/    # Splash + onboarding flow
    ├── home/          # Dashboard shell and home experience
    ├── search/        # Title search and subtitle source discovery
    ├── subtitles/     # Upload, translation, progress, preview, export
    ├── history/       # Saved translation jobs
    ├── settings/      # Preferences, legal placeholders, app info
    └── shared/        # Cross-feature domain models and widgets

test/
├── core/shared/       # Shared test helpers
└── features/          # Feature-level tests
```

---

## 🏗️ Architecture

SubFlix follows a **feature-first clean architecture**.

Each feature is split into:

- `domain/` → models, enums, repository contracts, pure logic
- `data/` → mock APIs, repositories, local data sources, platform adapters
- `application/` → Riverpod controllers, providers, orchestration
- `presentation/` → screens, widgets, and UI-specific helpers

### 🔌 Backend-ready by design

The app currently uses:

- mocked repositories
- deterministic fake data
- artificial latency
- local persistence for settings and history

This keeps the UI decoupled so a future **NestJS + Postgres** backend can replace only the repository and data-source layers.

---

## 🎯 Product Scope

SubFlix is built around two core user journeys:

### 🔎 Search and Translate

1. Search for a movie or series
2. Choose an English subtitle source
3. Pick a target language
4. Watch translation progress
5. Preview and export the result

### 📂 Upload and Translate

1. Pick an `.srt` or `.vtt` file
2. Validate and parse subtitle cues locally
3. Choose a target language
4. Run the same translation flow
5. Preview and export the translated file

---

## 🚀 Getting Started

### Prerequisites

- ✅ Flutter SDK `3.41+`
- ✅ Dart SDK `3.11+`
- ✅ Android Studio / Xcode / VS Code

### 1️⃣ Install dependencies

```bash
flutter pub get
```

### 2️⃣ Run code generation

SubFlix uses Riverpod generators, Freezed models, JSON serialization, and `go_router_builder` for typed routes.

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3️⃣ Run the app

```bash
flutter run
```

### 4️⃣ Configure Firebase auth

SubFlix now has a real Firebase-backed Google sign-in path. This repo does not
check in Firebase project secrets, so provide them at run time with
`--dart-define` values.

Current app identifiers:

- Android: `com.subflix.app.subflix`
- iOS: `com.subflix.app.subflix`
- macOS: `com.subflix.app.subflix`

Required base Firebase values:

- `FIREBASE_PROJECT_ID`
- `FIREBASE_MESSAGING_SENDER_ID`
- `FIREBASE_STORAGE_BUCKET`

Required per-platform values:

- Android: `FIREBASE_ANDROID_API_KEY`, `FIREBASE_ANDROID_APP_ID`
- iOS: `FIREBASE_IOS_API_KEY`, `FIREBASE_IOS_APP_ID`
- macOS: `FIREBASE_MACOS_API_KEY`, `FIREBASE_MACOS_APP_ID`
- Web: `FIREBASE_WEB_API_KEY`, `FIREBASE_WEB_APP_ID`

Google sign-in values:

- `GOOGLE_SERVER_CLIENT_ID`
- `GOOGLE_CLIENT_ID_IOS`
- `GOOGLE_CLIENT_ID_MACOS`
- `GOOGLE_CLIENT_ID_WEB`

Example:

```bash
flutter run \
  --dart-define=SUBFLIX_API_BASE_URL=http://localhost:3000 \
  --dart-define=FIREBASE_PROJECT_ID=your-project-id \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=1234567890 \
  --dart-define=FIREBASE_STORAGE_BUCKET=your-project.appspot.com \
  --dart-define=FIREBASE_ANDROID_API_KEY=android-api-key \
  --dart-define=FIREBASE_ANDROID_APP_ID=1:1234567890:android:abcdef \
  --dart-define=FIREBASE_IOS_API_KEY=ios-api-key \
  --dart-define=FIREBASE_IOS_APP_ID=1:1234567890:ios:abcdef \
  --dart-define=FIREBASE_MACOS_API_KEY=macos-api-key \
  --dart-define=FIREBASE_MACOS_APP_ID=1:1234567890:ios:abcdef \
  --dart-define=GOOGLE_SERVER_CLIENT_ID=server-client-id.apps.googleusercontent.com \
  --dart-define=GOOGLE_CLIENT_ID_IOS=ios-client-id.apps.googleusercontent.com \
  --dart-define=GOOGLE_CLIENT_ID_MACOS=macos-client-id.apps.googleusercontent.com
```

Web builds also need:

- `FIREBASE_WEB_AUTH_DOMAIN`
- `FIREBASE_WEB_MEASUREMENT_ID`

If you later switch to FlutterFire-generated config, you can replace the
runtime values in [firebase_options.dart](/C:/Users/Pedi/subflix-front/lib/core/app/firebase_options.dart).

---

## 🧪 Development Commands

### Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Format the codebase

```bash
dart format lib test
```

### Analyze the project

```bash
flutter analyze
```

### Run tests

```bash
flutter test
```

---

## ✅ Implemented

- ✅ Premium app shell and onboarding
- ✅ Search flow with mocked movie / series results
- ✅ Subtitle source selection
- ✅ Translation setup and progress orchestration
- ✅ Subtitle upload flow with `.srt` / `.vtt` parsing
- ✅ Preview with original / translated / bilingual modes
- ✅ Local subtitle export
- ✅ Translation history
- ✅ Settings and legal placeholders
- ✅ Tests for critical providers, repository mocks, and parsing / translation flows

---

## 🔮 Future Improvements

- 🔐 Real backend integration
- ☁️ Cloud-based translation jobs
- 👤 Authentication and user accounts
- 💳 Premium subscription flow
- 🌐 More subtitle languages and smarter translation quality layers
- 📡 Better offline handling and sync support
- 🧾 Richer app info, support, and legal content

---

## 🤝 Development Notes

- Use `dart run build_runner build --delete-conflicting-outputs` after changing annotated providers, Freezed models, or typed routes in `lib/core/app/router/app_routes_data.dart`.
- Keep feature logic inside `application/` and `domain/`, not inside screens.
- Prefer repository abstractions over direct platform or API calls from widgets.
- Shared reusable widgets belong in `lib/core/ui/widgets`.

---

## 💙 Vision

SubFlix is designed to feel like a **streaming-grade consumer product** mixed with an **AI productivity tool**:

- cinematic
- polished
- fast
- trustworthy
- future-ready

---

<div align="center">

Made with 💙 for SubFlix

</div>
