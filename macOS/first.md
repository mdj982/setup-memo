## install homebrew

```bash
# see also https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

# install g++ (gnu c++, not clang)

```bash
brew install gcc
# "g++" and "gcc" refers to clang's g++ in default, thus do:
ln -s /usr/local/bin/g++-9 /usr/local/bin/g++
ln -s /usr/local/bin/gcc-9 /usr/local/bin/gcc
```

# install VS Code
- Install VS Code from official site.
- Open VS Code. Press command+shift+P. Select "Shell Command: Install 'code' command in PATH
