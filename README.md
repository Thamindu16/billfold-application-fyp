# Billfold

A privacy-first personal finance app built with Flutter. Billfold lets you upload bank statements and payslips, keep them in a secure document locker, and see a quick overview of your income and expenses, with a full settings area for privacy, profile and app preferences.

> **Status:** Final year project, under active development.

---

## Features

- **Dashboard**: total income and expense summary, PDF statement upload, and a list of recently processed documents.
- **Document locker**: a dedicated view for all uploaded statements and payslips, with a PDF overview page for each document.
- **AI assistant chat**: chat interface for asking questions about your documents.
- **Profile**: edit name, email and phone number, change profile picture, change password, manage linked banks and currency, and log out.
- **Settings**: Account (profile, privacy and security, notifications) and General (language, currency, about / app version, dark mode toggle).
- **Privacy and security hub** with dedicated pages for:
  - Row-level security
  - Storage
  - Third-party AI
  - Document encryption
  - Auto-delete policy (7, 30 or 90 days)
  - Export data
  - Delete data
- **Light and dark themes**, switchable from Settings.

---

## Tech stack

| Area | Choice |
| --- | --- |
| Framework | Flutter (Dart) |
| State management | Local state (`setState`) and a singleton `DocumentStore` |
| Navigation | Drawer, bottom navigation bar and stacked pages (`Navigator.push`) |
| File import | [`file_selector`](https://pub.dev/packages/file_selector) |
| Backend / storage | Supabase (see the privacy and security pages) |

---

## Project structure

```text
lib/
├── core/                         # Shared helpers, constants, theme
├── data/                         # Data sources and repositories
├── view_models/                  # View models
├── views/
│   ├── auth/                     # Sign in and sign up
│   ├── chat/
│   │   └── ai_chat_view.dart
│   ├── dashboard/
│   │   └── dashboard_view.dart   # Home: stats, upload, recent documents, drawer
│   ├── document/
│   │   ├── document_locker_view.dart
│   │   └── pdf_overview_view.dart
│   ├── profile/
│   │   ├── profile_view.dart
│   │   ├── change_password_view.dart
│   │   ├── linked_banks_view.dart
│   │   └── currency_view.dart
│   └── settings/
│       ├── settings_view.dart
│       ├── notifications_view.dart
│       ├── language_view.dart
│       ├── currency_view.dart
│       ├── about_view.dart
│       └── privacy_security/
│           ├── privacy_security_view.dart
│           ├── row_level_security_view.dart
│           ├── storage_view.dart
│           ├── third_party_ai_view.dart
│           ├── documents_encrypted_view.dart
│           ├── auto_delete_view.dart
│           ├── export_data_view.dart
│           └── delete_data_view.dart
└── main.dart
```

---

## Getting started

### Prerequisites

- Flutter SDK **3.27 or newer** (the code uses `Color.withValues`)
- Dart SDK (bundled with Flutter)
- VS Code or Android Studio with the Flutter extension

### Run locally

```bash
git clone <repository-url>
cd Billfold_fresh
flutter pub get
flutter run
```

### Configuration

If the app connects to Supabase, keep your project URL and keys **out of version control**. Store them in a local `.env` file or pass them with `--dart-define`, and make sure that file is listed in `.gitignore`.

---

## Theme handling

The current theme value lives in the dashboard's state and is passed down to child pages through constructor parameters (`isDarkMode`, `onThemeChanged`). When you add a new page, accept `isDarkMode` and use it for colors so the page matches the active theme.

---

## Contributing

1. Create a branch: `git checkout -b feature/your-feature`
2. Commit with a short, clear message, for example `Add auto-delete settings page`
3. Push the branch and open a pull request

Please make sure `flutter analyze` shows no errors before you open a pull request, and that new pages support both light and dark mode.

---