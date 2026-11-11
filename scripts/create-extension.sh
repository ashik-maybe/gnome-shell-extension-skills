#!/bin/sh -e

# Create a new extension from the templates.
# Usage: ./create-extension.sh <uuid> <name> [directory]

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$SCRIPT_DIR/.."

UUID=${1:-example@gjs.guide}
NAME=${2:-Example Extension}
DEST=${3:-./$UUID}
SLUG=$(printf '%s' "$UUID" | cut -d@ -f1 | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9-')

if [ -z "$SLUG" ]; then
	SLUG=extension
fi

if [ -d "$DEST" ]; then
	echo "Directory exists: $DEST" >&2
	exit 1
fi

mkdir -p "$DEST/schemas" "$DEST/po"

sed -e "s/example@gjs.guide/$UUID/g" \
	-e "s/Example Extension/$NAME/g" \
	-e "s/org.gnome.shell.extensions.example/org.gnome.shell.extensions.$SLUG/g" \
	templates/metadata.json >"$DEST/metadata.json"

sed -e "s/example@gjs.guide/$UUID/g" \
	-e "s/Example Extension/$NAME/g" \
	templates/extension.js >"$DEST/extension.js"

sed -e "s/example@gjs.guide/$UUID/g" \
	-e "s/Example Extension/$NAME/g" \
	templates/prefs.js >"$DEST/prefs.js"

cp templates/stylesheet.css "$DEST/stylesheet.css"

sed -e "s/org.gnome.shell.extensions.example/org.gnome.shell.extensions.$SLUG/g" \
	templates/schemas/org.gnome.shell.extensions.example.gschema.xml \
	>"$DEST/schemas/org.gnome.shell.extensions.$SLUG.gschema.xml"

sed -e "s/example@gjs.guide/$UUID/g" \
	templates/po/example@gjs.guide.pot >"$DEST/po/$UUID.pot"

echo "Created $DEST"
