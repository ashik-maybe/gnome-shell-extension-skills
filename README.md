# GNOME Shell Skill Maker

This repository contains the `gnome-shell-extension` agent skill.

The skill teaches an agent to build GNOME Shell extensions for GNOME Shell 45 and later.

This skill is informed by the [gjs.guide extensions documentation](https://gjs.guide/extensions/) (MIT licensed).

## Install

Copy the repository to your skills directory:

```sh
cp -r gnome-shell-skill-maker ~/.agents/skills/gnome-shell-extension
```

Or symlink it:

```sh
ln -s "$PWD" ~/.agents/skills/gnome-shell-extension
```

## Use

Ask your agent to build a GNOME Shell extension.
The agent loads `SKILL.md` on demand.

## Verify

```sh
node --input-type=module --check < templates/extension.js
node --input-type=module --check < templates/prefs.js
node -e 'JSON.parse(require("fs").readFileSync("templates/metadata.json", "utf8"))'
xmllint --noout templates/schemas/org.gnome.shell.extensions.example.gschema.xml
```

## Layout

- `SKILL.md` — the skill entry point.
- `references/` — detailed reference files.
- `templates/` — copy-ready extension files.
- `scripts/` — helper scripts.
