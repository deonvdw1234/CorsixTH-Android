# CLAUDE.md

Created by Nieto Software

## Project summary
Personal, ad-free fork of CorsixTH-Android (Alan Woolley's Android port of the
CorsixTH engine, an open source reimplementation of Theme Hospital). GPL v3.
Kotlin app shell + native engine built with ndk-build. No ads. Google Play Games is
removed; Firebase (Crashlytics, Analytics, Perf) is optional and off in our CI.

## Build requirements
- Gradle 8.9 (wrapper), Android Gradle Plugin 8.7.3, Kotlin 2.0.21, KSP 2.0.21-1.0.28
- JDK 17+ to run Gradle (upstream CI uses Temurin 18); bytecode target Java 1.8
- compileSdk 35, targetSdk 35, minSdk 27; NDK not pinned (AGP default), ndk-build (no CMake)
- applicationId `za.co.nietosoftware.cth`; namespace stays `uk.co.armedpineapple.cth`
- Version from `versioning.gradle`: env BUILD_NUMBER, IS_SNAPSHOT
- Submodule `jni/CorsixTH` must be initialised: `git submodule update --init`
- Firebase is optional: plugins apply only if a non-empty `google-services.json` is in
  the repo root (gitignored). Runtime calls are guarded by `BuildConfig.FIREBASE_ENABLED`

## Key file locations
- `build.gradle`: single-module build (no settings.gradle, no app/ folder)
- `AndroidManifest.xml` (root): the real manifest. `src/main/` is unused legacy code
- `src/Java/uk/co/armedpineapple/cth/`: Kotlin sources
  - `setup/SetupViewModel.kt`: folder import, GOG installer, demo download
  - `Reporting.kt`, `Logging.kt`: Firebase consent and Crashlytics
  - `GameActivity.kt`: `signIn()`/`showAchievements()` are JNI stubs kept for the Lua menu
- `res/`: resources and translations (Crowdin)
- `jni/`: native code. `CorsixTH` (submodule), `SDL`, `SDL_mixer`, `SDL_gfx`, `LUA`,
  `LPEG`, `LFS`, `freetype2`, `lodepng`, `ffmpeg` (prebuilt static libs)
- `assets/game.zip`: generated at build time from the CorsixTH submodule Lua files
- `.github/workflows/nieto_build.yml`: our CI, uploads a release APK. Signs with optional
  `NIETO_KEYSTORE*` secrets if set, else the debug key
- `.github/workflows/android-ci.yml`, `build_and_sign.yml`: upstream, manual trigger only

## Rules for this fork
- Small, careful steps; commit with clear messages, then push the working branch.
- Never use recursive deletes (no `rm -rf` or similar).
- When something is broken, investigate and report the cause before changing anything.
- Do not modify the GPL licence (`LICENSE.txt`), credits (`README.md` credits) or `AUTHORS.md`.
- Never commit or bundle any Theme Hospital game data files.
- Any documentation written includes "Created by Nieto Software".
- Tone: warm, encouraging and concise.
- Never commit secrets, keystores (`*.jks`) or `google-services.json`.

## Status
- Phase 1 (investigation) and Phase 2 (secret-free CI, own applicationId,
  optional Firebase, optional keystore) done. Google Play Games removed.
