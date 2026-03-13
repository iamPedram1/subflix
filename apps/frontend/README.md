# 🎬✨ SubFlix

**SubFlix** is a premium Flutter mobile app for **AI subtitle translation**.  
It lets users search for movies or series, fetch mocked English subtitle sources, translate them into a target language, upload their own subtitle files, preview results, export translated subtitles, and revisit past jobs from history.

> 🚧 **Current status:** production-style frontend with **mock repositories + fake APIs** only.  
> The architecture is intentionally designed so a real **NestJS + Postgres** backend can be plugged in later with minimal UI rewrites.

---

## 🌟 Highlights

- 🔎 **Search flow** for movies and series with debounced input
- 📄 **Upload flow** for `.srt` and `.vtt` subtitle files
- 🌍 **Target language selection** with saved user preference
- 🧠 **Mock AI translation pipeline** with progress states
- 👀 **Preview screen** with original / translated / bilingual modes
- 📚 **Translation history** with reopenable jobs
- ⚙️ **Settings** for language defaults, theme preference, cache clearing, and app info
- 🎨 **Premium dark UI** with gradients, polished cards, strong spacing, and reusable design tokens
- 🧱 **Feature-first architecture** using Riverpod code generation and clean repository seams

---

## 📱 Core Features

### 🚀 Onboarding
- 3-slide onboarding flow
- Explains search, upload, translate, and export paths
- Persists onboarding completion locally

### 🏠 Home Dashboard
- Premium hero section
- Quick actions for search and upload
- Recent jobs section
- Trust/quality messaging

### 🔎 Search & Translate
- Debounced title search
- Mock movie/series results
- Mock subtitle source selection
- Translation setup screen
- Progress screen with staged updates

### 📂 Upload & Translate
- Local file picker for `.srt` and `.vtt`
- Demo subtitle file support for quick testing
- Local parsing into subtitle lines
- Shared translation setup flow

### 👀 Preview & Export
- Subtitle line preview list
- Original / translated / bilingual toggle
- Search inside subtitle lines
- Metadata summary
- Local export to subtitle file

### 📚 History
- Saved translation jobs
- Reopen past previews
- Empty state support

### ⚙️ Settings
- Preferred target language
- Theme mode selection
- Premium placeholder section
- About / support / legal placeholder pages
- Clear cache action

---

## 🧰 Tech Stack

| Layer | Tech |
|---|---|
| UI | Flutter |
| Routing | GoRouter |
| State | Riverpod + `riverpod_annotation` |
| Models | Freezed + JSON Serializable |
| Networking seam | Dio |
| Local persistence | SharedPreferences |
| File import | File Picker |
| Export | Local file generation |
| Testing | `flutter_test` + Riverpod containers |

---

## 🏗️ Architecture

SubFlix follows a **feature-first** structure:

```text
lib/
├─ core/
│  ├─ app/
│  ├─ providers/
│  ├─ styles/
│  ├─ ui/
│  ├─ utils/
│  └─ extensions/
├─ features/
│  ├─ onboarding/
│  ├─ home/
│  ├─ search/
│  ├─ subtitles/
│  ├─ history/
│  ├─ settings/
│  └─ shared/
test/
├─ core/shared/
└─ features/
```

Each feature is organized into:

- `domain/` → models, enums, repositories, pure logic
- `data/` → mock APIs, repositories, data sources, platform adapters
- `application/` → Riverpod providers, controllers, orchestration
- `presentation/` → screens, widgets, UI helpers

---

## 🧪 Mock-First by Design

This app does **not** call a real backend yet.

Instead it uses:

- ⏳ artificial latency
- 🎭 deterministic fake data
- 🗂️ local persistence for settings + history
- 🔌 clean repository abstractions for future backend replacement

That means we can later wire:

- NestJS APIs
- Postgres persistence
- real authentication
- premium billing
- cloud sync / job processing

without rebuilding the whole app shell.

---

## ▶️ Getting Started

### 1. Prerequisites

- Flutter `3.41+`
- Dart `3.11+`

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the app

```bash
flutter run
```

---

## 🛠️ Useful Commands

### Generate providers / Freezed / JSON code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Format the project

```bash
dart format lib test
```

### Analyze the codebase

```bash
flutter analyze
```

### Run tests

```bash
flutter test
```

---

## ✅ What’s Implemented

- ✅ Premium app shell and onboarding
- ✅ Search flow with subtitle source selection
- ✅ Translation setup + progress orchestration
- ✅ Upload flow with subtitle parsing
- ✅ Translation preview + local export
- ✅ History and settings screens
- ✅ Tests for critical providers and mock flows

---

## 🔮 Future Improvements

- 🔐 Real backend integration
- ☁️ Cloud-based translation jobs
- 👤 Authentication and user accounts
- 💳 Premium subscription flow
- 📤 Better share/export targets
- 🌐 More subtitle languages and richer translation quality logic

---

## 🤝 Development Notes

This repo is optimized for:

- modular Flutter scaling
- provider-driven orchestration
- reusable shared UI
- low-friction backend replacement later

If you’re extending the project, try to keep new work inside the existing feature boundaries and prefer repository/provider seams over direct widget-side logic.

---

## 💙 SubFlix Vision

SubFlix aims to feel like a **streaming-grade consumer app** mixed with a **smart AI productivity tool**:

- cinematic
- clean
- fast
- trustworthy
- future-ready

---

## 📄 License

Private project. `publish_to: none`
