# Debugging

Sources:
- https://gjs.guide/extensions/development/debugging.html
- https://gjs.guide/extensions/development/creating.html

## Test Environment

Wayland supports a nested Shell.

```sh
dbus-run-session gnome-shell --devkit --wayland
```

GNOME 48 and earlier use `--nested` instead of `--devkit`.

X11 does not support a nested Shell. Restart GNOME Shell instead.

1. Press Alt+F2.
2. Enter `restart`.
3. Run `gnome-extensions enable <uuid>`.

## Logs

```sh
journalctl -f -o cat /usr/bin/gnome-shell
```

Prefs logs come from `/usr/bin/gjs`.

## Logging

Use the `console` API.

- `console.debug()` — development messages.
- `console.warn()` — unexpected errors.
- `console.error()` — programmer errors.

Log only important messages.

## Environment Variables

- `SHELL_DEBUG=backtrace-warnings` — print a stack for warnings.
- `SHELL_DEBUG=backtrace-segfaults` — print a stack before a crash.
- `SHELL_DEBUG=all` — enable all options.

## Looking Glass

Press Alt+F2 and enter `lg`.

Looking Glass is a REPL and inspector. It runs JavaScript in the Shell process.

## GJS Console

Run `gjs-console` to test a small script.

The GJS console has no access to GNOME Shell modules.

## Reload

JavaScript engines cannot unload code. You must restart GNOME Shell after a code change.

## GDB

Use GDB for advanced debugging.

```sh
dbus-run-session -- gdb --args gnome-shell --devkit --wayland
```

Call `System.breakpoint()` in your code to halt the process.
Call `gjs_dumpstack()` in GDB to print the JavaScript stack.
Set `G_DEBUG=fatal-criticals` to break on `console.error()`.
