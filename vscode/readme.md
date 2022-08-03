## VS Code Settings

### Supported version
1.43.0

### Install
```bash
# download .deb package from official site
# https://code.visualstudio.com/download
sudo dpkg code_*.deb
```

### Quick custom settings
```bash
bash setall.sh
```

### Location: settings.json
Linux:
~/.config/Code/User/settings.json
Windows:
%APPDATA%\Code\User\settings.json
WSL:
${PWD}/Code/User/settings.json

### Location: keybindings.json
Linux:
~/.config/Code/User/keybindings.json
Windows:
%APPDATA%\Code\User\keybindings.json
WSL:
${PWD}/Code/User/keybindings.json

### Enable "Open with Code" in Nautilus (bionic)
#### Install Filemanager-Actions
```bash
sudo add-apt-repository ppa:daniel-marynicz/filemanager-actions
sudo apt update
sudo apt install filemanager-actions-nautilus-extension
fma-config-tool
```
#### Add the action
File > New action
Command >
Path: /usr/bin/code
Parameters: . --working-directory=%d/%b
Working Directory: %d/%b

### C++ Formatter
#### cpplint
- See also https://github.com/cpplint/cpplint
- Install pip
  ````bash
  # download get-pip
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  # for python3
  sudo apt install python3-distutils
  # install pip
  python3 get-pip.py
  # remove trash
  rm get-pip.py
  # may need to add path
  export PATH=${PATH}:~/.local/bin
  ````
- Install cpplint
  ````bash
  pip install cpplint
  ````
- Usage (simplest)
  ````bash
  # be sure that ./CPPLINT.cfg exists
  cpplint [filename]
  ````

### clang-format
- Install
  ````bash
  sudo apt install clang-format
  ````

- Usage
  ````bash
  clang-format [filename]
  # In the root of repository
  clang-format -style=google -dump-config > .clang-format
  # or use this ./.clang-format
  ````

### markdown-pdf
- Install font
  ````bash
  sudo apt install fonts-noto-cjk
  sudo apt install fonts-noto-cjk-extra
  ````
- In `settings.json`
  ````json
  "markdown-pdf.styles": [
      "css/markdown-pdf.css"
  ],
  "markdown-pdf.margin.top": "1.0cm",
  "markdown-pdf.margin.bottom": "2.5cm",
  "markdown-pdf.printBackground": true,
  "markdown-pdf.displayHeaderFooter": true,
  "markdown-pdf.headerTemplate": "<span class='title' style='display: none;'></span>",
  "markdown-pdf.footerTemplate": "<div style=\"position: relative; margin-top: 0.5cm; margin-left: 1cm; margin-right: 1cm; width: 100%; opacity: 0.5;\"><img style=\"height: 48px;\" src=\"data:image/png;base64,LOGO_BASE64ENCODED\" /></div><div style=\"position: relative; margin-top: 0.5cm; margin-bottom: 0.5cm; margin-left: 1cm; margin-right: 1cm; font-size: 9px; width: 100%;\"><div style=\"position: absolute; width: 100%; top: 0.3cm; text-align: right;\">p.<span class='pageNumber'></span></div></div>"
  ````
- In `css/markdown-pdf.css`
  ````css
  body {
      font-family: "Noto Sans CJK JP"
  }
  ````

- force new page: insert into markdown file: <div style="page-break-after: always;"></div>
- show total pages in `settings.json`: <span class='totalPages'></span>

### LaTeX environment
#### TeXLive
Download link: http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz
```bash
tar -xf install-tl-unx.tar.gz
cd install-tl-*
sudo ./install-tl
```
Add following commands to ~/.profile
```bash
export MANPATH=${MANPATH}:/usr/local/texlive/2019/texmf-dist/doc/man
export INFOPATH=${INFOPATH}:/usr/local/texlive/2019/texmf-dist/doc/info
export PATH=${PATH}:/usr/local/texlive/2019/bin/x86_64-linux
```
Logfile:
/usr/local/texlive/2019/install-tl.log

#### Trouble Shootings
- Extension LaTeX-Workshop never works =>
  - Remove ~/.config/Code
  - Remove ~/.vscode/extension
  - Reinstall VS Code
- Compiling with error for sample.tex =>
  - The same shells (e.g. dvipdfmx) might exist in /usr/bin , so let them placed out of ${PATH}
