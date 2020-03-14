## VS Code Settings

### Supported version
1.43.0

### Quick setting
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

### location: keybindings.json
Linux:  
~/.config/Code/User/keybindings.json  
Windows:  
%APPDATA%\Code\User\keybindings.json  
WSL:  
${PWD}/Code/User/keybindings.json

### Enable "Open with Code" in Nautilus
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