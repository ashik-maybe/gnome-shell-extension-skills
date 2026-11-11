# UI Patterns

Sources:
- https://gjs.guide/extensions/topics/popup-menu.html
- https://gjs.guide/extensions/topics/quick-settings.html
- https://gjs.guide/extensions/topics/notifications.html
- https://gjs.guide/extensions/topics/dialogs.html
- https://gjs.guide/extensions/topics/search-provider.html
- https://gjs.guide/extensions/topics/session-modes.html
- https://gjs.guide/extensions/topics/st-widgets.html

## Panel Indicator

```js
import St from 'gi://St';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';

this._indicator = new PanelMenu.Button(0.0, this.metadata.name, false);

const icon = new St.Icon({
    icon_name: 'face-laugh-symbolic',
    style_class: 'system-status-icon',
});
this._indicator.add_child(icon);

Main.panel.addToStatusArea(this.uuid, this._indicator);
```

## Popup Menu

```js
import * as PopupMenu from 'resource:///org/gnome/shell/ui/popupMenu.js';

this._indicator.menu.addAction('Item', () => console.debug('activated'));

const item = new PopupMenu.PopupMenuItem('Label');
this._indicator.menu.addMenuItem(item);
```

Menu item classes:

- `PopupMenuItem` — text label.
- `PopupImageMenuItem` — icon and label.
- `PopupSwitchMenuItem` — label and switch.
- `PopupSubMenuMenuItem` — submenu.
- `PopupSeparatorMenuItem` — separator.
- `PopupMenuSection` — group of items.

Animations: `BoxPointer.PopupAnimation.NONE`, `.SLIDE`, `.FADE`, `.FULL`.

## Quick Settings

Quick Settings requires GNOME 45 or later.

```js
import * as QuickSettings from 'resource:///org/gnome/shell/ui/quickSettings.js';

const toggle = new QuickSettings.QuickToggle({
    title: _('Example'),
    iconName: 'selection-mode-symbolic',
    toggleMode: true,
});
```

Use `QuickSettings.SystemIndicator` to group items.

```js
const indicator = new QuickSettings.SystemIndicator();
indicator.quickSettingsItems.push(toggle);
Main.panel.statusArea.quickSettings.addExternalIndicator(indicator);
```

Classes: `QuickToggle`, `QuickMenuToggle`, `QuickSlider`, `QuickSettingsItem`.

## Notifications

Simple notification:

```js
Main.notify('Title', 'Body');
Main.notifyError('Failed', error.message);
```

Full notification:

```js
const notification = new MessageTray.Notification({
    source: customSource,
    title: _('Title'),
    body: _('Body'),
    urgency: MessageTray.Urgency.NORMAL,
});
notification.addAction(_('Close'), () => {});
```

Urgency: `LOW`, `NORMAL`, `HIGH`, `CRITICAL`.

## Dialogs

```js
import * as ModalDialog from 'resource:///org/gnome/shell/ui/modalDialog.js';

const dialog = new ModalDialog.ModalDialog();
dialog.contentLayout.add_child(new St.Label({text: 'Hello'}));
dialog.setButtons([
    {label: 'Close', action: () => dialog.destroy()},
]);
dialog.open(global.get_current_time());
```

Use `Dialog.MessageDialogContent` for a title and description.
Use `Dialog.ListSection` for a list of items.

## Search Provider

Implement the `SearchProvider` interface.

```js
this._provider = new SearchProvider(this);
Main.overview.searchController.addProvider(this._provider);
```

Register in `enable()`. Unregister in `disable()`.

## Session Modes

Add `session-modes` to `metadata.json`.

```json
{
  "session-modes": ["user", "unlock-dialog"]
}
```

Watch `Main.sessionMode`:

```js
this._sessionId = Main.sessionMode.connect('updated', () => {
    this._onSessionModeChanged();
});
```

## St Widgets

Import `St` from `gi://St`. Use `St.Icon`, `St.Label`, `St.Button`, `St.ScrollView`, and `St.Bin`.

Use `style_class` to apply CSS from `stylesheet.css`.
