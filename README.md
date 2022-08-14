# boost_msme_app_builder

A new Flutter project.

## Pre-Requisites for taking a build

1. Change fpConstants - all values
2. Change Manifest.xml (android) - application display name
3. Change info.plist (iOS/runner) - application 'CFBundleDisplayName'


## How to get a new apk/ipa
```bash
$ flutter clean
$ flutter pub get
$ flutter pub run flutter_launcher_icons:main 
$ flutter build apk --release --split-per-abi
$ flutter build ios --release
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
