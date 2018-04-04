## Commit deleted file
```
## if you want to commit one deleted file
$ git rm <file name>
## if you want to commit all deleted files
$ git rm $(git ls-files --deleted)
```

## Variety of git add 
* see [here][1]
* According to the explanation above,
	* add * means add all files in the current directory, except for files, whose name begin with a dot. This is your shell functionality and Git only ever receives a list of files.

	* add . has no special meaning in your shell, and thus Git adds the entire directory recursively, which is almost the same, but including files whose names begin with a dot.

## If you need to get branch on remote
* [here][2]

```
# switch to a branch in remote (new_remote_branch)
git checkout -b new_local_branch -t origin/new_remote_branch

# show all branches including remotes
git branch -a 
```

## When you change to gitignore was not reflected

```
$ git rm -r --cached .
$ git add .
```

[1]:https://stackoverflow.com/questions/26042390/git-add-asterisk-vs-git-add-period
[2]:https://git-scm.com/docs/git-checkout