# Setup a computer (macOS)
## General
* `zsh`: in general use `zshrc` 


## List an app
* [here](https://www.makeuseof.com/tag/list-installed-apps-mac/)
```
ls -la /Applications/ > InstalledAppsTerminal.txt
```

## Google drive
* Download "Backup and Sync"
* Sync
* Change the local folder name to "GoogleDrive"
	* Pause "Backup and Sync"
	* Change file name "GoogleDrive"
	* Restart "Backup and Sync" 
	* Relocate the file to "GoogleDrive"

## GlobalProtect
* MIT VPN
* Portal address: `gpvpn.mit.edu`

## Zotero
* Sync with existing account
* Install better bibtex (citation key format: `[auth:lower][year]`)
* Make sure to check Google drive setup and the path is corrects
	* The folder name should be "GoogleDrive"

## Avast, R, Google Chrome, Firefox
* Follow the instruction
* Google Chrome: use google account to sync
* Firefox: install AdBlocker for YouTube (maybe not Enhancer for YouTube)

## R
* Use `https://cloud.r-project.org/bin/macosx/base/` to find binariles of R builds for macOS
* To change language setting, write `export LC_ALL=en_US.UTF-8` in `~/.bash_profile` and $ `source ~/.bash_profile`.

```
# modified from http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows
# from https://gist.github.com/florianhartig/10527319

# run on old computer / r version
setwd("/Users/tomoyasasaki/GoogleDrive/admin/computer/") # or any other existing temp directory
packages <- installed.packages()[,"Package"]
save(packages, file = "Rpackages")


# run on new computer / r version
# setwd("/Users/Florian/Dropbox/temp") # or any other existing temp directory
setwd("/Users/tomoyasasaki/GoogleDrive/admin/computer/") # or any other existing temp directory
load("Rpackages")
for (p in setdiff(packages, installed.packages()[,"Package"]))
install.packages(p)
```

## Python
1. Install `pyenv`
2. Install python with `pyenv`
3. Install `pyenv-virtualenv`
4. Install `pip` in one of your environment

### pyenv
* Thanks to Shusei ([here](https://github.com/Shusei-E/Code_Tips/blob/master/MacOS/SettingEnvironment.md))
* Also check [here](https://towardsdatascience.com/python-how-to-create-a-clean-learning-environment-with-pyenv-pyenv-virtualenv-pipx-ed17fbd9b790)
* Install with `brew install pyenv`
* In `.bash_profile` or `.zshrc`

```
PS1="%1~ \$ "
#export PYENV_ROOT="/usr/local/var/pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
#eval "$(pyenv init -)"
```

* In `.zshrc`

```
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
```

* Install available python version `pyenv install -l`
* Install python version with `pyenv install [ver]`

### pyenv-virtualenv
* More convenient to control multiple versions
* You can also use `pyenv-virtualenv`: `brew install pyenv-virtualenv`
	* New environment: `pyenv virtualenv [ver] [envname]`
	* Activate environment: `pyenv activate [envname]`
	* Deactivate environment: `pyenv deactivate`

### pip
* Check [here](https://github.com/pypa/get-pip)

```
curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# In one of your pyenv-virutalenv environments,
python get-pip.py
```

* Save and reinstall pip installed package ([here](https://stackoverflow.com/questions/7225900/how-can-i-install-packages-using-pip-according-to-the-requirements-txt-file-from), [here](https://stackoverflow.com/questions/11033753/transfer-python-setup-across-different-pc/11034515))
* Problem of `freeze` ([here](https://medium.com/@tomagee/pip-freeze-requirements-txt-considered-harmful-f0bce66cf895))
* (Probably) no need to check for each enviornment

```
pip freeze > /path/to/requirements.txt
pip install -r /path/to/requirements.txt
```
	
## Tex
* Install ghostscript with brew `brew install ghostscript`
* Download MacTex and custom install without ghostscript
* Update `sudo tlmgr update --self --all`s

## brew
* `homebrew-cask` might be useful but won't use for now ([here](https://yutaszk23.hatenadiary.jp/entry/2014/12/16/030653) or [here](https://queryok.ikuwow.com/entry/stop-brew-cask/))
* Export brew installed packages ([here](https://apple.stackexchange.com/questions/279077/how-can-i-install-all-brew-packages-listed-i``n-a-text-file)): `brew leaves > brew_leaves.txt`
* Install exported brew installed packages ([here](https://apple.stackexchange.com/questions/279077/how-can-i-install-all-brew-packages-listed-in-a-text-file)): `for i in $(cat brew_leaves); do; brew install "$i"; done`

## OneTab
* Export URLs

## DBeaver
* Download from [here](https://dbeaver.io/download/)

## Git
* Use git from brew ([here](https://apple.stackexchange.com/questions/93002/how-to-use-the-homebrew-installed-git-on-mac)): `brew install git`

## Github
* Connect github with new credential

### Dropbox and Github
* Not compatible in general
* Main computer: sync everything
* Sub computer: sync **only** gitignored folders
* Make sure to update gitignore when you re-sync and re-initialize the git
* Make sure not to delete online smart-sync files
* Move some files if necessary. Some files might not be synced from the remote github repo because they are ignored

#### When migrating the main computer
* When there is huge, smart-synced files
	1. Make sure that every update is already available in the online repo
	2. Delete non-gitignored folders
	3. Re-clone the github repo to non-Dropbox folder
	4. Move files in the cloned folder to the existing corresponding folder in Dropbox
	5. Re-init as github repo
* When there is no smart-synced files
	1. Make sure that every update is already available in the online repo
	2. Move gitignored folders file to non-Dropbox folder
	3. Delete the github Dropbox folder
	4. Re-clone the github repo to Dropbox
	5. Put back files moved in Step 2 to the github repo