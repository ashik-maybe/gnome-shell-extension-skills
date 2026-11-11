# GJS Fundamentals

Sources:
- https://gjs.guide/guides/gjs/asynchronous-programming.html
- https://gjs.guide/guides/gjs/memory-management.html
- https://gjs.guide/guides/gjs/style-guide.html
- https://gjs.guide/guides/gobject/basics.html

## Async Programming

GJS uses the GLib main loop. You use `Promise` and `async`/`await`.

```js
import GLib from 'gi://GLib';
import Gio from 'gi://Gio';

const file = Gio.File.new_for_path('test.txt');
const [, contents] = await new Promise((resolve, reject) => {
    file.load_contents_async(GLib.PRIORITY_DEFAULT, null, (_file, res) => {
        try {
            resolve(file.load_contents_finish(res));
        } catch (e) {
            reject(e);
        }
    });
});
```

Use `Gio._promisify()` for platform methods.

```js
Gio._promisify(Gio.File.prototype, 'load_contents_async');
await file.load_contents_async(GLib.PRIORITY_DEFAULT, null);
```

Cancel work with `Gio.Cancellable`.

## Main Loop Sources

```js
this._timeoutId = GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 5, () => {
    return GLib.SOURCE_CONTINUE;
});
```

Remove the source in `disable()`.

```js
if (this._timeoutId) {
    GLib.Source.remove(this._timeoutId);
    this._timeoutId = null;
}
```

## GObject

Construct an object with a property dictionary.

```js
const label = new Gtk.Label({label: 'Example'});
```

Use `camelCase` accessors.

```js
label.useMarkup = true;
```

Connect to a signal.

```js
this._handlerId = label.connect('activate-link', (label, uri) => {
    return true;
});
```

Disconnect the signal.

```js
if (this._handlerId)
    label.disconnect(this._handlerId);
```

## Memory

GJS traces objects to variables. An object is freed when no variable traces it.

1. You store every source ID and handler ID on `this`.
2. You remove every source in `disable()`.
3. You disconnect every signal in `disable()`.
4. You null every reference after `destroy()`.

Do not use a boolean `_destroyed` flag. Null the reference instead.

## Style

1. Use 4 spaces for indentation.
2. Use single quotes.
3. Use `const` and `let`. Never use `var`.
4. Use ES6 classes.
5. Use `constructor()`, not `_init()`.
6. Separate import groups with one blank line.
7. Keep lines under 200 characters.

## Gio

Use `Gio.File` for files.
Use `Gio.DBus` for D-Bus.
Use `Gio.Subprocess` for subprocesses.
Use `Gio.Cancellable` to cancel work.
