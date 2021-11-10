# VS code

## Shortcuts

### Switch between editor and terminal
* Open the keybindings.json from the editor: CMD-SHIFT-P -> Preferences: Open Keyboard Shortcuts File and add these entries:
[here](https://stackoverflow.com/questions/42796887/switch-focus-between-editor-and-integrated-terminal-in-visual-studio-code)

```
// Toggle between terminal and editor focus
{ 
  "key": "ctrl+`", 
  "command": "workbench.action.terminal.focus"
  },
{ "key": "ctrl+`", 
  "command": "workbench.action.focusActiveEditorGroup", 
  "when": "terminalFocus"
  }
```


