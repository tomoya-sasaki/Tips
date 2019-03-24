# Shortcuts
| Keys | Contents |
| :-----------|------------:|
| <kbd>ctrl</kbd>  + <kbd>/</kbd> | comment out |
| | |

# Display
## Magic to expand display

```
from IPython.core.display import display, HTML 
display(HTML("<style>.container { width:100% !important; }</style>"))
```

## Debugging
* Jupyter notebookがエラー吐くたびprint 文バラまいて間違い探ししている人、今すぐエラー直後に空セルで%debugと打って実行しましょう。
