# Extension Anatomy

Source: https://gjs.guide/extensions/overview/anatomy.html

An extension is a directory. The directory name equals the UUID. GNOME Shell loads the extension from that directory.

## Install Paths

- User extension: `~/.local/share/gnome-shell/extensions/<uuid>/`
- System extension: `/usr/share/gnome-shell/extensions/<uuid>/`

## Required Files

- `metadata.json` — extension metadata.
- `extension.js` — the entry point. It default-exports a class.

## Optional Files

- `prefs.js` — the preferences window.
- `stylesheet.css` — CSS for Shell widgets.
- `schemas/` — GSettings schema files.
- `locale/` — compiled translations.
- `po/` — translation sources.

## Metadata Fields

Required:

- `uuid` — `extension-id@namespace`.
- `name` — short name.
- `description` — short description.
- `shell-version` — array of supported Shell versions.
- `url` — repository URL.

Optional:

- `gettext-domain` — gettext domain.
- `settings-schema` — GSettings schema ID.
- `session-modes` — `user`, `unlock-dialog`, or `gdm`.
- `version-name` — user-visible version.
- `donations` — donation links.

The `version` field belongs to EGO. Do not set it.

## Lifecycle

1. GNOME Shell imports `extension.js`.
2. GNOME Shell constructs the class. The constructor runs once.
3. GNOME Shell calls `enable()` when the extension is enabled.
4. GNOME Shell calls `disable()` when the extension is disabled.

The constructor must call `super(metadata)`.
The constructor must not create UI, connect signals, or add sources.

## Extension Class

```js
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';

export default class ExampleExtension extends Extension {
    enable() {
        // Create UI and connect signals here.
    }

    disable() {
        // Destroy everything from enable() here.
    }
}
```

## ExtensionBase API

- `uuid` — the UUID string.
- `path` — the extension directory path.
- `dir` — the extension directory as a `Gio.File`.
- `metadata` — the metadata object.
- `getSettings(schema)` — returns a `Gio.Settings` object.
- `initTranslations(domain)` — initializes gettext.
- `gettext(str)` — translates a string.
- `ngettext(str, strPlural, n)` — translates a plural string.
- `pgettext(context, str)` — translates a string with context.
- `lookupByUUID(uuid)` — finds an extension by UUID.
- `lookupByURL(url)` — finds an extension by URL.

## Process Isolation

`extension.js` runs in the GNOME Shell process. It uses `St`, `Clutter`, `Meta`, and `Shell`.

`prefs.js` runs in a separate GTK process. It uses `Gtk`, `Adw`, and `Gio`.

A shared module must not import `St`, `Clutter`, `Gtk`, `Gdk`, or `Adw`.

## InjectionManager

Use `InjectionManager` to override a Shell method.

```js
this._injectionManager = new InjectionManager();

this._injectionManager.overrideMethod(Panel.prototype, 'toggleCalendar',
    originalMethod => {
        return args => {
            originalMethod.call(Main.panel, ...args);
        };
    });

// In disable():
this._injectionManager.clear();
this._injectionManager = null;
```
