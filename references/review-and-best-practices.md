# Review and Best Practices

Sources:
- https://gjs.guide/extensions/review-guidelines/review-guidelines.html
- https://gjs.guide/extensions/review-guidelines/best-practices.html

## Lifecycle Rules

1. You create nothing before `enable()`.
2. You create objects, connect signals, and add sources in `enable()`.
3. You destroy objects, disconnect signals, and remove sources in `disable()`.
4. You remove every source in `disable()`, even if the callback returns `GLib.SOURCE_REMOVE`.

## Process Isolation

1. You never import `Gtk`, `Gdk`, or `Adw` in `extension.js`.
2. You never import `St`, `Clutter`, `Meta`, or `Shell` in `prefs.js`.
3. You keep prefs-only modules in a `prefs/` directory.

## Deprecated Modules

| Deprecated | Replacement |
| --- | --- |
| `ByteArray` | `TextDecoder`, `TextEncoder` |
| `Lang` | ES6 classes |
| `Mainloop` | `GLib.timeout_add()` |

## Code Quality

1. You keep the entry point small.
2. You keep `enable()` and `disable()` adjacent.
3. You split logic into modules.
4. You use a linter.
5. You avoid unnecessary `try-catch` blocks.
6. You avoid optional chaining for guaranteed APIs.
7. You avoid boolean lifecycle flags.
8. You use `constructor()`, not `_init()`.

## Cleanup Order

In `destroy()`, follow this order:

1. Remove timeouts and sources.
2. Disconnect signals.
3. Release child references.
4. Call `super.destroy()`.

## UI Rules

1. You use `St.Icon` in `extension.js`.
2. You use `Gtk.Image` in `prefs.js`.
3. You never use an emoji as an icon.
4. You use a Shell component for progress, not ASCII text.

## Metadata Rules

1. The UUID uses `extension-id@namespace`.
2. The namespace is your domain or account.
3. You never use `gnome.org` as the namespace.
4. `shell-version` lists only stable releases.
5. You drop `session-modes` if you use only `user` mode.

## GSettings Rules

1. The schema ID starts with `org.gnome.shell.extensions`.
2. The schema path starts with `/org/gnome/shell/extensions`.
3. The schema file is named `<schema-id>.gschema.xml`.
4. You include the schema XML in the ZIP.

## Legal Rules

1. The license is GPL-2.0-or-later compatible.
2. You attribute copied code.
3. You include no copyrighted or trademarked content without permission.
4. You use no telemetry.

## AI-Generated Code

AI-generated files must start with this notice:

```js
// Generated with AI for personal use.
// Do NOT upload to extensions.gnome.org (EGO) unless you understand JavaScript
// and can maintain this code.
```

The author removes the notice before submission only if the author understands and maintains the code.
