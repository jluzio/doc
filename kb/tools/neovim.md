# NeoVim

# Starters/Distros
- https://github.com/nvim-lua/kickstart.nvim
- https://nvchad.com
- https://www.lazyvim.org
- https://astronvim.com
- https://www.lunarvim.org

# Other libs
- Nerd Fonts
https://www.nerdfonts.com/font-downloads
JetBrainsMono Nerd Font

Original: Cascadia Mono

# Help
- :Tutor
- :help
## Tutor current
5.2


# Lua
- https://www.lua.org/docs.html
- https://www.lua.org/pil/contents.html
- https://nvchad.com/docs/quickstart/learn-lua


# Aliases
## Bash
~~~bash
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
alias nvchad='NVIM_APPNAME="nvchad" nvim'
alias lazyvim='NVIM_APPNAME="lazyvim" nvim'
~~~

## PowerShell
~~~powershell
function nvim-kickstart-func { $env:NVIM_APPNAME="nvim-kickstart"; nvim }
Set-Alias nvim-kickstart nvim-kickstart-func
function nvchad-func { $env:NVIM_APPNAME="nvchad"; nvim }
Set-Alias nvchad nvchad-func
function lazyvim-func { $env:NVIM_APPNAME="lazyvim"; nvim }
Set-Alias lazyvim lazyvim-func
~~~

# Shell Setup
Info: https://vi.stackexchange.com/questions/42813/how-to-manually-set-nvims-data-folder
~~~
:h starting
:h base-directories
$XDG_CONFIG_HOME
$XDG_DATA_HOME
$XDG_STATE_HOME

Windows: $TMPDIR and $TEMP
~~~

## Git Bash
~~~lua
-- JC (start)
if string.match(os.getenv('SHELL'), 'bash%.exe$') then
  vim.o.shellcmdflag = '-c'
end
-- JC (end)
~~~


## PowerShell
:help shell-powershell
~~~
*shell-powershell*
	To use PowerShell:  
		let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
		let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
		let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
		let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
		set shellquote= shellxquote=
~~~

# Distro Setup
## Uninstall
~~~bash
rm -rf ~/.config/nvim && rm -rf ~/.local/share/nvim
~~~

## Linux
~~~bash
sudo apt install make gcc g++
~~~
(g++ used in treesitter yaml? confirm if needed)

## kickstart
https://github.com/nvim-lua/kickstart.nvim
~~~powershell
git clone https://github.com/nvim-lua/kickstart.nvim.git $ENV:USERPROFILE\AppData\Local\nvim-kickstart
~~~

## nvchad
https://nvchad.com/docs/quickstart/install
~~~powershell
git clone https://github.com/NvChad/NvChad $ENV:USERPROFILE\AppData\Local\nvchad --depth 1
~~~

## lazyvim
http://www.lazyvim.org/installation
~~~powershell
git clone https://github.com/LazyVim/starter $ENV:USERPROFILE\AppData\Local\lazyvim
~~~


## MinGW (GCC)
~~~bash
choco install -y mingw
~~~

## Install help parser
~~~
:TSUpdate vimdoc
~~~

## mason
https://github.com/williamboman/mason.nvim
