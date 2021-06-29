# General
## x-code 
* If you get the following error

```
make: error: unable to find utility "make", not a developer tool or in PATH
xcodebuild: error: SDK "/Library/Developer/CommandLineTools/SDKs/MacOSX10.13.sdk" cannot be located.
clang: error: unable to find utility "clang", not a developer tool or in PATH

Do not report this issue to Homebrew/brew or Homebrew/core!
```

* `xcode-select --switch /Library/Developer/CommandLineTools`
* [Ref1](https://github.com/Homebrew/legacy-homebrew/issues/48736), [Ref2](https://stackoverflow.com/questions/30781214/troubles-when-i-use-homebrew)

# Install
## `ghostscript`
* `link` does not work if you have already installed MacTex because MacTex also installs `ghostscript`. 
* Generally not to use MacTex would be the solution
* Check [here](https://github.com/Homebrew/homebrew-core/issues/11368). More [Ref](https://tex.stackexchange.com/questions/539364/ghostscript-mactex-conflicts-with-homebrew)

