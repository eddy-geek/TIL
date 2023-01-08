# Remapping keyboard keys and writing macros with Hawck

## Setup

Hawck is currently using console keymaps and has issues with the us keymap (see [Hawck#77](https://github.com/snyball/Hawck/issues/77)).

So I'm using a custom copy of `us-latin1.kmap.gz` with `keycode   3 = at two` to have `@` at the same place as in my kodetravel Xkb layout.

## Macro

One temporary use of Hawck (until KDE gains back custom global hotkeys under wayland) is insert arbitrary text:

```lua
cat email.hwk
up + alt + control + key "grave" => write "email1@foo.com"
up + shift + control + key "grave" => write "email2@foo.com"
```

For macros triggered with the meta/super key it's a bit more involved as the key is not defined in the console keymap.

```lua
-- add super/meta/windows keys as it's not built-in
kbd.map.mod_codes[125] = true
super = held(125)
__keys[125] = true

up + super + key "grave" => write("some macro")
```

## Key remapping

Where hawck has no equivalent that I know of is in conditional remapping for a single keyboard.

In my case, i want to remap te Calculator key of my laptop to PrintScreen key:

```lua
cat calc.hwk
-- XF86_calculator key = 140
-- PrtScr = 99
key(140) => replace(99)
```

Note that the upstream `replace` ignores any modifier for now.

