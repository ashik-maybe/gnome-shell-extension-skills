# Translations

Sources:
- https://gjs.guide/extensions/development/translations.html
- https://gjs.guide/extensions/overview/anatomy.html#gettext-domain

## Gettext Domain

Add `gettext-domain` to `metadata.json`.

```json
{
  "gettext-domain": "example@gjs.guide"
}
```

GNOME Shell initializes translations when it sees this field.

## Translation Functions

Import the functions from the same module as the base class.

```js
import {Extension, gettext as _, ngettext, pgettext} from 'resource:///org/gnome/shell/extensions/extension.js';
```

- `gettext(str)` — translates one string. Alias it to `_()`.
- `ngettext(str, strPlural, n)` — translates a plural string.
- `pgettext(context, str)` — translates a string with context.

Use `String.prototype.format()` for interpolated values.

```js
const body = ngettext('You have been notified %d time',
    'You have been notified %d times',
    count).format(count);
```

## Generate the POT File

Run `xgettext` from the extension directory.

```sh
xgettext --from-code=UTF-8 --output=po/example@gjs.guide.pot *.js
```

Regenerate the POT file after you add or remove a string.

## Compile Translations

Use `gnome-extensions pack` with the `po` directory.

```sh
gnome-extensions pack --podir=po <uuid>
```

## Mark Strings

Mark every user-visible string with `_()`.
Do not translate log messages.
Do not translate code comments.
