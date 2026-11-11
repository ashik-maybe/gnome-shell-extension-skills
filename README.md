# GNOME Shell Extension Skill

[![skills.sh](https://skills.sh/b/ashik-maybe/gnome-shell-extension-skills)](https://skills.sh/ashik-maybe/gnome-shell-extension-skills)

An agent skill that teaches AI agents to build GNOME Shell extensions with GJS for GNOME Shell 45 and later.

## Install

### Project

```sh
npx skills add ashik-maybe/gnome-shell-extension-skills
```

### Global

```sh
npx skills add ashik-maybe/gnome-shell-extension-skills -g
```

### Manual

Symlink the repository into your agent's skills directory.

```sh
# Global (OpenCode compatibility path)
ln -s "$PWD" ~/.agents/skills/gnome-shell-extension

# Project
ln -s "$PWD" .agents/skills/gnome-shell-extension
```

## Use

Ask your agent to build a GNOME Shell extension. The agent loads `SKILL.md` on demand.

## Contents

- `SKILL.md` — skill entry point.
- `references/` — detailed reference files.
- `templates/` — copy-ready extension files.
- `scripts/` — helper scripts.

## Verify

```sh
node --input-type=module --check < templates/extension.js
node --input-type=module --check < templates/prefs.js
node -e 'JSON.parse(require("fs").readFileSync("templates/metadata.json", "utf8"))'
xmllint --noout templates/schemas/org.gnome.shell.extensions.example.gschema.xml
```

## License

MIT. Informed by the [gjs.guide extensions documentation](https://gjs.guide/extensions/) (MIT licensed).
