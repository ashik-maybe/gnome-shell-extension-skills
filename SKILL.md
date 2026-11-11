---
name: gnome-shell-extension
description: >
  Build GNOME Shell extensions with GJS for GNOME Shell 45 and later. Use for
  extension.js, prefs.js, metadata.json, GSettings, translations, panel
  indicators, popup menus, quick settings, notifications, dialogs, search
  providers, debugging, and EGO review checks.
---

# GNOME Shell Extension

You build GNOME Shell extensions.
An extension is JavaScript that GNOME Shell loads at runtime.
The extension runs in the GNOME Shell process.
The preferences run in a separate GTK process.
You target GNOME Shell 45 and later.
GNOME Shell 45 uses ESModules.

## Hard Rules

1. You create nothing before `enable()` runs.
2. You create UI, connect signals, and add sources in `enable()`.
3. You destroy, disconnect, and remove everything in `disable()`.
4. You never make `disable()` asynchronous.
5. You never import `Gtk`, `Gdk`, or `Adw` in `extension.js`.
6. You never import `St`, `Clutter`, `Meta`, or `Shell` in `prefs.js`.
7. You never use deprecated modules.
8. You keep `enable()` and `disable()` next to each other.
9. You split logic into modules.
10. You keep the entry point small.
11. You put `settings-schema` in `metadata.json`.
12. You call `this.getSettings()` without arguments.

## Workflow

1. You read the user's requirements.
2. You choose the extension UUID, name, and description.
3. You copy the templates from `templates/`.
4. You edit `metadata.json`.
5. You implement `extension.js`.
6. You implement `prefs.js` if the extension has settings.
7. You mark every user-visible string with `_()`.
8. You add accessible roles and states to custom widgets.
9. You test the extension in a nested GNOME Shell.
10. You run the pre-submission checklist.
11. You package the extension with `gnome-extensions pack`.

## Reference Map

| Question | File |
| --- | --- |
| What files does an extension need? | `references/extension-anatomy.md` |
| How do I import modules? | `references/imports-and-modules.md` |
| How do I add preferences? | `references/preferences-and-settings.md` |
| How do I add translations? | `references/translations.md` |
| How do I debug? | `references/debugging.md` |
| How do I build a panel, menu, or dialog? | `references/ui-patterns.md` |
| How do I support accessibility? | `references/accessibility.md` |
| What does the EGO review require? | `references/review-and-best-practices.md` |
| How do I target another Shell version? | `references/porting-and-version-targeting.md` |
| How do I use GJS, GObject, and async? | `references/gjs-fundamentals.md` |
| Where is the source documentation? | `references/source-map.md` |

## Templates

You copy these files to start a new extension.

1. `templates/metadata.json`
2. `templates/extension.js`
3. `templates/prefs.js`
4. `templates/stylesheet.css`
5. `templates/schemas/org.gnome.shell.extensions.example.gschema.xml`
6. `templates/po/example@gjs.guide.pot`

You run `scripts/create-extension.sh` to copy and rename the templates.

## Pre-Submission Checklist

You verify each item before you send an extension to EGO.

1. `metadata.json` has `uuid`, `name`, `description`, `shell-version`, and `url`.
2. The extension directory name matches the UUID.
3. `extension.js` default-exports a class that extends `Extension`.
4. The class implements `enable()` and `disable()`.
5. The constructor creates no UI, connects no signal, and adds no source.
6. `disable()` destroys every object from `enable()`.
7. `disable()` disconnects every signal.
8. `disable()` removes every main loop source.
9. `disable()` is not asynchronous.
10. `extension.js` imports no `Gtk`, `Gdk`, or `Adw`.
11. `prefs.js` imports no `St`, `Clutter`, `Meta`, or `Shell`.
12. The GSettings schema ID starts with `org.gnome.shell.extensions`.
13. The schema path starts with `/org/gnome/shell/extensions`.
14. The schema file is named `<schema-id>.gschema.xml`.
15. The extension uses `_()` for every user-visible string.
16. The extension uses no emoji as an icon.
17. The extension logs only important messages.
18. The entry point class is small.
19. The code has no unnecessary `try-catch` blocks.
20. The code has no boolean lifecycle flags.
21. The code uses `constructor()`, not `_init()`.
22. The license is GPL-2.0-or-later compatible.
23. AI-generated files carry the required notice.

## Common Pitfalls

1. You lose a reference to a timeout source. The source keeps running after `disable()`.
2. You lose a reference to a signal handler. The callback keeps tracing objects.
3. You use `destroy()` but keep using the object. GJS raises a critical error.
4. You subclass a Shell class and override a method. A Shell update can break the extension.
5. You add thousands of lines to `extension.js`. Review becomes hard.
6. You put shared code in a module that imports `St`. `prefs.js` cannot load it.
