# General syntax
## `for` loop
```
>>> for i in range(3):
>>> 	print(i)
0
1
2

>>> for i in range(0,3):
>>> 	print(i)
0
1
2

>>> for i in range(2, -1, -1):
>>> 	print(i)
2
1
0
```

## More and less
* `10:`: more than 10 (does not include 10th object)
* `:10`: less than 10 (does not include 10th object)

## Add/subtract/multiple/divide and assign new value
```
i = 2
i += 3
i
# 5

i = 2
i *= 3
i
# 6

i = 2
i /= 3
i
# 0.666666666...
```

## Copying the objects
Since ` = ` in Python just create the reference to the list, not the copies of actual list, you need to copy the list in order to keep the original list while modifying the new list (refer [here](http://stackoverflow.com/questions/23200969/how-to-clone-or-copy-a-set-in-python))

```
# you can slice
new_list = old_list[:]

# you can create new list by list() function
new_list = list(old_list)

# you can copy 
import copy
new_list = copy.copy(old_list)
new_lsit = old_list.copy() # equivalent to above, but recommmend above method

# if the list contains the objects and you want to copy them as well, you can use deepcopy. 
#If you use the method above, you cannot create the copy of the objects in the list, rather the reference to the older list.
import copy
new_list = copy.deepcopy(old_list)
```

# class method
## @staticmethod
By using static method, you could change the part of the logic of the method inside and you can override with sub-class.

```
class Parent(object):

    def __init__(self, text):
        self.text = text

    @staticmethod
    def newlines(s):
        return s.replace('\n','\r')

    def printer(self):
        return self.newlines(self.text)

class Child(Parent):

  @staticmethod
  def newlines(s):
    return s.replace('\n\r', '\n')

p = Parent('\n\r')
p.printer()
>>> '\r\r'

p = Child('\n\r')
p.printer()
>>> '\n'
# This means that Child class override with Parent but changing the logic of `newlines`.
``` 

## Use of object and class method
```
class Parent(object):

    class_var = 'parent_class_var'

    @classmethod
    def class_method(cls):
        print('cls: {}'.format(cls))
        print("class_var: {}".format(cls.class_var))

    @staticmethod
    def static_method(raw_str):
        print(raw_str.strip())

if __name__ == '__main__':
    raw_str = 'He has been fired\n'
    # cls: <class '__main__.Parent'>
    # class_var: parent_class_var
    Parent.class_method()
    # He has been fired
    Parent.static_method(raw_str)

    parent = Parent()
    # cls: <class '__main__.Parent'>
    # class_var: parent_class_var
    parent.class_method()
    # He has been fired
    parent.static_method(raw_str)
```

## Profile
```
$ python -m cProfile -o main.profile -s time main.py
```
`-m cProfile` to profile, `-o main.profile` to save, and `-s ncalls` to sort by number of the function called, and `-s time` to sort by spent time. For detail, see [here][1]

[1]:http://blog.amedama.jp/entry/2016/08/30/214718

## move files
```
## move one file
import shutil
shutil.copyfile('origin', 'destination')
shutil.copy('origin', 'destination')

## if you also copy meta-data
shutil.copy2('origin', 'destination')

## move all files in a folder to a new folder
shutil.copyfile('origin', 'destination')

## ir you move all files to a existing folder
from distutils import dir_util
dir_util.copy_tree('origin', 'destination')

## move whole path
import shutil
shutil.move('old path', 'new path)
```

# Speed
## Calculate sqrt
* Using `x**.5` is faster than `numpy.sqrt(x)`

```
start = time.time()
for i in range(100000):
    np.sqrt(10000)
end = time.time()
print(end - start)

0.14058399200439453

start = time.time()
for i in range(100000):
    10000 ** .5
end = time.time()
print(end - start)
0.008305072784423828
```

## Extend or append a vector
* `append` argument in `list` object is faster than imputing `numpy` object

## Zip a file

```
import shutil
shutil.make_archive(output_filename, 'zip', dir_name)
```

## Read word file
* `textract` package can deal with both `.doc` and `docx` files.
* This package supports other types as well. For the detail see [here][1]
* You need `swig` to install. Install by `$ brew install swig` or `$ sudo apt-get swig` before `pip install textract`.

```
import textract
text = textract.process("path/to/file.extension")
```

# Misc
## Install
### Installing `camelot-py[cv]`
* You need to install `camelot-py[cv]`, not `camelot` or `camelot-py` (`pip3 install camelot-py[cv]`) [Ref1](https://github.com/atlanhq/camelot/issues/142), [Ref2](https://github.com/atlanhq/camelot/issues/389)
* You may get this error after installing and importing `camelot-py[cv]`

```
>>> import camelot
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/camelot/__init__.py", line 6, in <module>
    from .io import read_pdf
  File "/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/camelot/io.py", line 5, in <module>
    from .handlers import PDFHandler
  File "/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/camelot/handlers.py", line 9, in <module>
    from .parsers import Stream, Lattice
  File "/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/camelot/parsers/__init__.py", line 4, in <module>
    from .lattice import Lattice
  File "/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/camelot/parsers/lattice.py", line 27, in <module>
    from ..image_processing import (
  File "/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/camelot/image_processing.py", line 5, in <module>
    import cv2
  File "/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/cv2/__init__.py", line 5, in <module>
    from .cv2 import *
ImportError: dlopen(/usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/cv2/cv2.cpython-37m-darwin.so, 2): Symbol not found: _inflateValidate
  Referenced from: /usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/cv2/.dylibs/libpng16.16.dylib (which was built for Mac OS X 10.13)
  Expected in: /usr/lib/libz.1.dylib
 in /usr/local/var/pyenv/versions/snake/lib/python3.7/site-packages/cv2/.dylibs/libpng16.16.dylib
```
* If you get the error above, try to install `octave` and `opencv` etc using `brew intall octave opencv`. [Ref1](https://github.com/Homebrew/homebrew-core/issues/24857), [Ref2]
* While installing `octave`, you may fail to install `open-mpi` because of an error caused by gfotran (`gcc`)

```
==> Installing octave dependency: gcc
==> Downloading https://ftp.gnu.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.xz
######################################################################## 100.0%
==> ../configure --build=x86_64-apple-darwin16 --prefix=/usr/local/Cellar/gcc/9.3.0_1 --libdir=/usr/local/Cellar/gcc/
==> make BOOT_LDFLAGS=-Wl,-headerpad_max_install_names
==> make install
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink bin/gfortran
Target /usr/local/bin/gfortran
already exists. You may want to remove it:
  rm '/usr/local/bin/gfortran'

To force the link and overwrite all conflicting files:
  brew link --overwrite gcc

To list all files that would be deleted:
  brew link --overwrite --dry-run gcc

Possible conflicting files are:
/usr/local/bin/gfortran -> /usr/local/gfortran/bin/gfortran
```
* Then if you have not installed other versions of `gcc` before, simply follow the guide `brew link --overwrite gcc`. If you do have it from elsewhere, you might need to remove it first. [Ref1](https://github.com/Homebrew/brew/issues/3168), [Ref2](https://stackoverflow.com/questions/49862397/gcc-stopped-working-after-brew-update)


```
configure: error: No xcodebuild tool and no system framework headers found, use --with-sysroot or --with-sdk-name to provide a path to a valid SDK
/private/tmp/openjdk-20200730-29234-3rv7rb/jdk14u-jdk-14.0.1-ga/build/.configure-support/generated-configure.sh: line 82: 5: Bad file descriptor
configure exiting with result code 1
```

* If you get an error above while installing opencv, try this [ref](https://stackoverflow.com/questions/17980759/xcode-select-active-developer-directory-error) or [ref](https://stackoverflow.com/questions/30781214/troubles-when-i-use-homebrew)

```
# you might need to move between these two below
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

sudo xcode-select --switch /Library/Developer/CommandLineTool
```

* Check the version of opencv-python: compatibility with macOS

## Errors
```
pip is configured with locations that require TLS/SSL, however the ssl module in Python is not available
```

* Reinstall pyenv, pyenv-virtualenv, and python

```
brew uninstall python
rm -rf $(pyenv root)
brew uninstall pyenv-virtualenv   # you may not have this installed, but...
brew uninstall pyenv
```

## Which python version is available
* Right now in my MacBook
	* Python2: default
	* Python3: available (use pip3 for installing libraries)
	* pyenv: snake for python3 and py2 for python2

## Install pip in remote computer locally
* Reference [here][2].

1. Download `wget https://bootstrap.pypa.io/get-pip.py`
2. `python get-pip.py --user`. This will install pip to your local directory `(.local/bin)`.
3. Set path. Write `PATH=$PATH:~/.local/bin` in your `.bash_profile`.

## Install pyenv in remote computer locally
* Reference [here][3], [here][4], [here][5].

1. `$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv`. Be aware of your directory installing the `pip`.
2. `$ echo 'export PYENV_ROOT="/home/usrname/.pyenv"' >> ~/.bash_profile`. I changed `$HOME/.pyenv` to `/home/usrname/.pyenv`. `usrname` part could be any directory.
3. `$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile`.
4. `$ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile`
5. `source .bash_profile`
6. Start! (`$ pyenv` will show you the options).

## Setting `pyenv`
* On cluster computer

1. First install `pyenv` without `sudo`

```
git clone git://github.com/yyuu/pyenv.git ~/.pyenv
```

2. Then add following lines in `.bash_profile`
```
export PYENV_ROOT="/home/tomoyas/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
```
For installation, check Shusei's github.

[1]:https://textract.readthedocs.io/en/stable/
[2]:https://gist.github.com/saurabhshri/46e4069164b87a708b39d947e4527298
[3]:https://github.com/pyenv/pyenv
[4]:https://github.com/Shusei-E/Code_Tips/blob/master/MacOS/SettingEnvironment.md
[5]:https://qiita.com/maskedw/items/aaa2fd7abfd493cf2820
