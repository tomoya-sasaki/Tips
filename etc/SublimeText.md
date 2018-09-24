# Folding 
## Shortcuts

| Options | Command |
| - | - |
| ブロックを閉じる | Command + Option + [ |
| ブロックを開く | Command + Option + ] |
| すべて閉じる| Command + k, Command + 1 |
| すべて開く| Command + k, Command + j |

カンマで区切られているショートカットは、Command + kの後にCommand + 1を押します。つまりCommandは2回押すことになります。 

## Move between panes

The keyboard shortcut to toggle between panes?

```
cmd-k, cmd-left/cmd-right moves the focus left or right
ctrl-1 moves to pane 1
ctrl-2 moves to pane 2
```

# How to multiple panels
## Set new layout
* A package `origami` affect cursor so avoid creating a new panel with it.
* But you can still use the shortcuts of it. <kbd>cmd</kbd> + <kbd>K</kbd> and then press the arrow keys with modifiers.
	* no modifiers: travel to an adjacent pane
	* <kbd>shift</kbd>: carry the current file to the destination
	* <kbd>alt (option)</kbd>: clone the current file to the destination
	* <kbd>command</kbd>: create an adjacent pane

```
[{
    "id": "view",
    "children": [{
        "id": "layout",
        "children": [
            {
                 "command": "set_layout",
                 "caption" : "Custom: 3 Pane (2T 1B)",
                 "mnemonic": "C",
                 "args": {
                    "cols": [0.0, 0.5, 1.0],
                    "rows": [0.0, 0.5, 1.0],
                    "cells": [
                        [0, 0, 1, 1],
                        [1, 0, 2, 1],
                        [0, 1, 2, 2]
                    ]
                }
            },
            {
                 "command": "set_layout",
                 "caption" : "Custom: 3 Pane (1T 2B)",
                 "mnemonic": "C",
                 "args": {
                    "cols": [0.0, 0.5, 1.0],
                    "rows": [0.0, 0.5, 1.0],
                    "cells": [
                        [0, 0, 2, 1],
                        [0, 1, 1, 2],
                        [1, 1, 2, 2]
                    ]
                }
            },
            {
             "command": "set_layout",
             "caption" : "Custom: 4",
             "mnemonic": "C",
             "args": {
                "cols": [0.0, 0.5, 1.0],
                "rows": [0.0, 0.5, 1.0],
                "cells": [
                    [0, 0, 1, 1],
                    [1, 0, 2, 2],
                    [0, 1, 1, 2]
                ]
            }
        }
        ]
    }]
}]
```

# Terminal
* Use `terminalview`, `terminal` is bad

