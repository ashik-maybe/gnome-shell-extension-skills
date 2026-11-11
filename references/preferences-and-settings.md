# Preferences and Settings

Sources:
- https://gjs.guide/extensions/development/preferences.html
- https://gjs.guide/extensions/topics/extension.html

## GSettings

GSettings stores settings. The backend shares values between `extension.js` and `prefs.js`.

## Schema

Create `schemas/<schema-id>.gschema.xml`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<schemalist>
  <schema id="org.gnome.shell.extensions.example" path="/org/gnome/shell/extensions/example/">
    <key name="show-indicator" type="b">
      <default>true</default>
    </key>
  </schema>
</schemalist>
```

The schema ID must start with `org.gnome.shell.extensions`.
The path must start with `/org/gnome/shell/extensions`.

## Compile

Run `glib-compile-schemas schemas/`.
The `gnome-extensions` tool compiles schemas automatically since GNOME 44.

## Metadata

Add `settings-schema` to `metadata.json`.

```json
{
  "settings-schema": "org.gnome.shell.extensions.example"
}
```

## Read Settings

Call `this.getSettings()` without arguments.

```js
this._settings = this.getSettings();
this._settings.bind('show-indicator', this._indicator, 'visible',
    Gio.SettingsBindFlags.DEFAULT);
```

Watch a key:

```js
this._settings.connect('changed::show-indicator', (settings, key) => {
    console.debug(`${key} = ${settings.get_value(key).print(true)}`);
});
```

## Preferences Window

Implement `fillPreferencesWindow(window)`.

```js
import Gio from 'gi://Gio';
import Adw from 'gi://Adw';

import {ExtensionPreferences, gettext as _} from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js';

export default class ExamplePreferences extends ExtensionPreferences {
    fillPreferencesWindow(window) {
        const page = new Adw.PreferencesPage({
            title: _('General'),
        });
        window.add(page);

        const group = new Adw.PreferencesGroup({
            title: _('Appearance'),
        });
        page.add(group);

        const row = new Adw.SwitchRow({
            title: _('Show Indicator'),
        });
        group.add(row);

        const settings = this.getSettings();
        settings.bind('show-indicator', row, 'active',
            Gio.SettingsBindFlags.DEFAULT);
    }
}
```

## Test Preferences

Run `gnome-extensions prefs <uuid>`.
Run `dconf watch /org/gnome/shell/extensions/<id>`.
Prefs logs come from `/usr/bin/gjs`.
