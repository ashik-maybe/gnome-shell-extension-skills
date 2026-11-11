# Imports and Modules

Source: https://gjs.guide/extensions/overview/imports-and-modules.html

GNOME Shell 45 uses ESModules. You use the `import` statement.

## Import Forms

1. GI libraries use `gi://`.
2. GNOME Shell modules use `resource://`.
3. Your own modules use relative paths.

```js
// GI libraries
import St from 'gi://St';
import Gtk from 'gi://Gtk?version=4.0';

// GNOME Shell modules in extension.js
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';

// GNOME Shell modules in prefs.js
import {ExtensionPreferences} from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js';

// Your own modules
import * as Utils from './utils.js';
```

## Resource Paths

The path is case-sensitive.

- `extension.js` uses `resource:///org/gnome/shell/...`.
- `prefs.js` uses `resource:///org/gnome/Shell/Extensions/js/...`.

## Exports

The entry point files use a default export.

```js
export default class ExampleExtension extends Extension {
}
```

Your own modules use named exports.

```js
export function createIndicator(name) {
    return new PanelMenu.Button(0.0, name, true);
}
```

## Module Split

You split large extensions into modules. Each module has one responsibility.

Put prefs-only modules in a `prefs/` directory.
Put Shell-only modules in a `shell/` directory.
Put shared modules in a `lib/` directory.

A shared module must not import `St`, `Clutter`, `Gtk`, `Gdk`, or `Adw`.
