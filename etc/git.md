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

* If you do not want to remove all cash,

```
$ git rm -r --cached [file_name]
```

# Errors

## Cannot pull
* Following error
 
```
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream-to=origin/<branch> tomoya
```

* Try this

```
$ git pull origin master
$ git push -u origin master
```

"The first cmd pull remote to local master branch, the second push to remote. -u means add upstream (tracking) reference, which solve the problem" ([ref][3])

# How to move git repo
* With all history and branches
* See [here](https://gist.github.com/tomoya-sasaki/731369b9fbe50a9052c753642cf65dda)
* [This](https://www.atlassian.com/git/tutorials/git-move-repository) might work as well.

[1]:https://stackoverflow.com/questions/26042390/git-add-asterisk-vs-git-add-period
[2]:https://git-scm.com/docs/git-checkout
[3]:https://stackoverflow.com/questions/12054223/git-new-user-trying-to-do-pull-and-getting-some-confusing-messages