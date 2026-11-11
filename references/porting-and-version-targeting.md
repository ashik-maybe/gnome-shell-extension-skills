# Porting and Version Targeting

Sources:
- https://gjs.guide/extensions/development/targeting-older-gnome.html
- https://gjs.guide/extensions/upgrading/gnome-shell-45.html
- https://gjs.guide/extensions/upgrading/gnome-shell-51.html

This skill targets GNOME Shell 45 and later.

## Declare Support

List every supported version in `metadata.json`.

```json
{
  "shell-version": ["45", "46", "47"]
}
```

## Feature Detection

Check for a method before you call it.

```js
if (method)
    method();
```

## Version Detection

```js
import * as Config from 'resource:///org/gnome/shell/misc/config.js';

const [major, minor] = Config.PACKAGE_VERSION.split('.').map(Number);
```

GNOME Shell 40 and later use major versions only.

## GNOME 45 Changes

1. Extensions use ESModules.
2. `extension.js` imports `Extension` from `resource:///org/gnome/shell/extensions/extension.js`.
3. `prefs.js` imports `ExtensionPreferences` from `resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js`.
4. `ExtensionUtils` is gone.
5. Use `console.debug()`, `console.warn()`, and `console.error()`.

## GNOME 51 Changes

1. `disable()` must not be asynchronous.
2. The `vertical` property of St widgets is gone.
3. Use `Clutter.ClickGesture` and other controllers for events.
4. `Shell.GLSLEffect` is gone. Use `Clutter.ShaderEffect`.

## Porting Guides

Use the gjs.guide porting guides for each Shell version.
