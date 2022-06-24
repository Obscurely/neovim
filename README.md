# Neovim configuration
This is my neovim configuration that is based on [NVChad](https://github.com/NvChad/NvChad). This repo only includes the files in lua custom dir and requires installation of NVChad, by doing this you can update NVChad without the risk of loosing any configuration done.

## !ARCH LINUX ONLY! Installation procces (using script)
1. First clone this repo
```shell
git clone https://github.com/Obscurely/neovim
```
2. CD into the clone dir
```shell
cd neovim
```
3. Run the installer script with sudo
```
sudo ./install_arch_linux.sh
```

4. If no errors ocurred, for first run, start it with this command
```
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
```

## Any time you want to start it
```
nvim
```
