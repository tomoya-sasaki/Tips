## Commit deleted file
```
## if you want to commit one deleted file
$ git rm <file name>
## if you want to commit all deleted files
$ git rm $(git ls-files --deleted)
```

## If you need to get branch on remote
* [here][1]

```
# switch to a branch in remote (new_remote_branch)
git checkout -b new_local_branch -t origin/new_remote_branch

# show all branches including remotes
git branch -a 
```

[1]:https://git-scm.com/docs/git-checkout