# Accessibility

Source: https://gjs.guide/extensions/development/accessibility.html

Clutter and St support accessibility by default.
Standard widgets already use the correct roles and states.
You fix accessibility when a custom widget breaks it.

## Concepts

- `Atk.Role` — the purpose of an element.
- `Atk.RelationType` — the link between elements.
- `Atk.StateType` — the current state of an element.

## Set a Role

Use the `accessible_role` property.

```js
const widget = new St.Bin({
    accessible_role: Atk.Role.CHECK_BOX,
});
```

## Set a Label

Use the `label_actor` property.

```js
this.label_actor = this.label;
```

## Set a State

Use `add_accessible_state()` and `remove_accessible_state()`.

```js
this.add_accessible_state(Atk.StateType.CHECKED);
this.remove_accessible_state(Atk.StateType.CHECKED);
```

## Custom Widget Pattern

1. Set `accessible_role` in the constructor.
2. Set `label_actor` to the label.
3. Update the state when the value changes.
4. Use the CSS pseudo-class `checked` for the visual state.

## Test

Test with a screen reader. Test keyboard navigation. Test the high-contrast theme.
