# CLAUDE.md

Created by Nieto Software

## Project summary
Personal, ad-free fork of CorsixTH-Android (Alan Woolley's Android port of the
CorsixTH engine, an open source reimplementation of Theme Hospital). GPL v3.
Kotlin app shell + native engine built with ndk-build. Upstream contains no ads,
but does ship Firebase (Crashlytics, Analytics, Perf) and Google Play Games.

## Build requirements
- Gradle 8.9 (wrapper), Android Gradle Plugin 8.7.3, Kotlin 2.0.21, KSP 2.0.21-1.0.28
- JDK 17+ to run Gradle (upstream CI uses Temurin 18); bytecode target Java 1.8
- compileSdk 35, targetSdk 35, minSdk 27; NDK not pinned (AGP default), ndk-build (no CMake)
- applicationId = namespace `uk.co.armedpineapple.cth` (not set separately)
- Version from `versioning.gradle`: env BUILD_NUMBER, IS_SNAPSHOT
- Submodule `jni/CorsixTH` must be initialised: `git submodule update --init`
- `google-services.json` in repo root is required while the Firebase plugins are applied
  (it is gitignored and never committed)

## Key file locations
- `build.gradle`: single-module build (no settings.gradle, no app/ folder)
- `AndroidManifest.xml` (root): the real manifest. `src/main/` is unused legacy code
- `src/Java/uk/co/armedpineapple/cth/`: Kotlin sources
  - `setup/SetupViewModel.kt`: folder import, GOG installer, demo download
  - `Reporting.kt`, `Logging.kt`: Firebase consent and Crashlytics
  - `PlayGamesService.kt`, `AchievementsTracker.kt`: Google Play Games
- `res/`: resources and translations (Crowdin)
- `jni/`: native code. `CorsixTH` (submodule), `SDL`, `SDL_mixer`, `SDL_gfx`, `LUA`,
  `LPEG`, `LFS`, `freetype2`, `lodepng`, `ffmpeg` (prebuilt static libs)
- `assets/game.zip`: generated at build time from the CorsixTH submodule Lua files
- `.github/workflows/`: upstream CI (`android-ci.yml`, `build_and_sign.yml`), need secrets

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
- Phase 1 (investigation) done. Phase 2 (secret-free CI build + separate
  applicationId `za.co.nietosoftware.cth`) awaits owner approval.
