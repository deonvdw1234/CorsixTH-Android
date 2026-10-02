# Game file overrides

Created by Nieto Software

Edited copies of individual CorsixTH game files. The `createGameZip` task in
`build.gradle` packs these into `assets/game.zip` in place of the originals from
the `jni/CorsixTH` submodule, so the submodule itself stays untouched.

Paths mirror `jni/CorsixTH/CorsixTH/`. Each file starts with a comment naming
the original it replaces, and every change is marked "Nieto Software".

| File | Change |
|---|---|
| `Lua/dialogs/android_play_menu.lua` | Hides the Google Play Games icons, which do nothing in this build |
| `Lua/dialogs/android_menu_button.lua` | Larger touch area for the in-game menu (gear) button |
| `Lua/dialogs/place_objects.lua` | "Rotate Object" button under the object list when placing items |

When the submodule is updated, compare each file against its new original and
carry the marked changes across.

These are engine scripts only. Never put Theme Hospital game data here.
