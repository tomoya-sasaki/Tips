# git

## `.gitignore`

* Recursively ignore files

```
# ignore all csv files in file folder
file/**/*.csv
```

## Checkout to remote branches
* [here][2]

```
# switch to a branch in remote (new_remote_branch)
git checkout -b new_local_branch -t origin/new_remote_branch

# or this may work
$ git checkout --track origin/newsletter
Branch newsletter set up to track remote branch newsletter from origin.
Switched to a new branch 'newsletter'

# show all branches including remotes
git branch -a

# or do simply
git reset HEAD
```

## Clone with `ssh`

```
$ git clone git$@github.com:username/reponame.git
```

## Adding a project to Github
* Create a new repo on Github
* Initialize the local directory as Git repo `git init -b main`
* Add and commit
* Add the URL to the remote repo

```
git remote add origin <REMOTE URL>
# verifies the remote URL
git remote -v
# if you have only done `git init` in the second step
git branch -M main
# pushes the changes in your local repo to remote repo
git push -u origin main
```

## Re-clone existing repo with token

```
git remote remove origin
git remote add origin https://[TOKEN]@github.com/[USER]/[REPO]
git push
# or git push --set-upstream origin master
```


## Commit deleted file
```
## if you want to commit one deleted file
$ git rm <file name>
## if you want to commit all deleted files
$ git rm $(git ls-files --deleted)
```
* When you delete files manually

```
$ git add -u
```

## Update a forked repo

```
# Add the remote, call it "upstream":
git remote add upstream https://github.com/whoever/whatever.git

# Fetch all the branches of that remote into remote-tracking branches
git fetch upstream

# Make sure that you're on your master branch:
git checkout main

# Rewrite your master branch so that any commits of yours that
# aren't already in upstream/master are replayed on top of that
# other branch:
git rebase upstream/main

# push with updated branch and repo
git push -f origina main
```

* Suppose you checkout to a branch that is included in the updated forked repo

```
# after git rebase
git checkout -b new_branch --track origin/new_branch

# push to the remote repo (mine, not the original one)
git push -u origin new_branch
# maybe this is also fine
git push -f origin new_branch
```


## Variety of `git add`
* see [here][1]
* According to the explanation above,
	* `git add *` means add all files in the current directory, except for files, whose name begin with a dot. This is your shell functionality and Git only ever receives a list of files.

	* `git add .` has no special meaning in your shell, and thus Git adds the entire directory recursively, which is almost the same, but including files whose names begin with a dot. This does not remove files that have been deleted from the disk.
	* `git add -u` only adds currently tracked files (which have been modified) to the staging area and also checks if they have been deleted (if yes, they are removed from staging area). This means that it does not stage new files.
	* `git add -A` performs both of `git add .` and `git add -u`, that is, stages your entire directory as it is.


## When you change to gitignore was not reflected

```
$ git rm -r --cached .
$ git add .
```

* If you do not want to remove all cash,

```
$ git rm -r --cached [file_name]
```

## How to fix previous commits

* If you want to change the last commit
```
$ git commit --amend
```

* If you want to change the commit before the last one
* What `git commit --fixup` does is to create a new commit with the same message as the commit you want to fix, but with the prefix "fixup!". Then, you can rebase the commit on the commit you want to rebase on with `git rebase -i --autosquash`. This will automatically move the "fixup!" commit to the right place.

```
$ git add .
# commit_hash is the hash of the commit you want to fix
$ git commit --fixup <commit_hash>
# commit_hash2 is the hash of the commit you want to rebase on
$ git rebase -i --autosquash <commit_hash2> # or `git rebase -i --autosquash master` if you want to rebase on master
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

## Error about email
* Error message

```
Can't finish GitHub sharing process
Successfully created project 'myproject' on GitHub, but initial push failed:
remote: error: GH007: Your push would publish a private email address.
```

### Solution
* Set an email address in Git. Use your GitHub-provided no-reply email address.
	* Setting your email address for every repository on your computer
	`git config --global user.email "{ID}+{username}@users.noreply.github.com"`
	* Setting your email address for a single repository
	`git config user.email "{ID}+{username}@users.noreply.github.com"`
* Reset the author information on your last commit:
`git commit --amend --reset-author`
* Now you can push the commit with the noreply e-mail address, and future commits will have the noreply e-mail address as well.
`git push`
* Once you configure Git, commits will use your alternate “noreply” email address, and any pushes that don’t will be rejected.

# How to move git repo
* With all history and branches
* See [here](https://gist.github.com/tomoya-sasaki/731369b9fbe50a9052c753642cf65dda)
* [This](https://www.atlassian.com/git/tutorials/git-move-repository) might work as well.

# Github cloned repo
## Mac mini
* `geotrade`
* `Tips`
* `IV_sensitivity_analysis`



[1]:https://stackoverflow.com/questions/26042390/git-add-asterisk-vs-git-add-period
[2]:https://git-scm.com/docs/git-checkout
[3]:https://stackoverflow.com/questions/12054223/git-new-user-trying-to-do-pull-and-getting-some-confusing-messages