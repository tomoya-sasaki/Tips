# Website hosting at github
* For example, [academicpages](https://github.com/academicpages/academicpages.github.io)

## Setup
* You might also need to install [Java](https://www.oracle.com/java/technologies/downloads/)
	* x64 for Intel processors and Arm 64 for M1/M2 processors
### Ruby (for macOS Catalina)
* Install rbenv: follow [here](https://github.com/rbenv/rbenv)
	* In the following steps, use the installed Ruby, not the system Ruby. 
* Move to the directory containing website materials
* Change Ruby version with `rbenv local ...` at the local directory
	* Check if the version has changed from the system Ruby with `ruby -v`
* Do `gem install bundler`
* Then, follow the rest of the steps in the github repo [here](https://github.com/academicpages/academicpages.github.io)

### After setting up
* Make sure to `.gitignore` irrevant folders