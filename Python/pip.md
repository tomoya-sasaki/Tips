#Install and use pip in a local directory without root/sudo access.
#####By: [@saurabhshri](https://github.com/saurabhshri)

##Why?
Many users when are given server access, do not have root (or sudo) privileges and can not simply do
`sudo apt-get install python-pip` .
Here's an easy way you can install and use pip without root (or sudo) access in a local directory.
**Note** : This works without `easy_install` too.

##How?

1. Download pip from an online repository : `wget https://bootstrap.pypa.io/get-pip.py`
2. Install the downloaded package into a local directory : `python get-pip.py --user`
   This will install pip to your local directory `(.local/bin)`.
3. Now you may navigate to this directory `(cd .local/bin)` and then use `pip` or better set your $PATH variable
   this directory to use `pip` anywhere : `PATH=$PATH:~/.local/bin` followed by `source ~/.bashrc` to apply the changes.

And that's it. You may now install all python modules you require via pip in a local directory without root.

##Gist of Gist

```
wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py --user
cd .local/bin
./pip install <package_name> --user
```
