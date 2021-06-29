# How to use Mac KeyChain to store GitHub repos credentials?

You know the pain, you cloned a repo over HTTPS, and now Git asks you for your password each time you want to push or pull.

Chances are you already have the `git credential-osxkeychain` command installed.
If not, just install Git with brew: `brew install git`.

Once installed, just tell Git to use the KeyChain to store your credentials:
```
git config --global credential.helper osxkeychain
```

Next time you clone a repo via HTTPS, you’ll be prompt for granting access to KeyChain.
That’s it. Any future authentication will be done transparently by Git reading the KeyChain record.