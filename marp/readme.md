# Use Marp

## Install

### Install newer nodejs
````bash
$ cd ~
$ curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
$ sudo bash nodesource_setup.sh
$ sudo apt install nodejs
$ node -v
v14.17.6
$ rm nodesource_setup.sh
````

### Try disposable Marp
````bash
$ npx @marp-team/marp-cli@latest --html true slide-src.md -o slide.html
````

### Install Marp globally
````bash
$ npm install -g @marp-team/marp-cli
````

## Basic Command
````bash
$ marp --html true slide-src.md -o slide.html
$ marp --html true --allow-local-files -o slide.pdf slide-src.md
````
