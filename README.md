# Calibre Container

## Config (optional)
If you have custom setup instructions:
 - `cp custom_config.sh.example custom_config.sh` 
 - `vim custom_config.sh`

## Installation
 - `apt-get install vagrant virtualbox`
 - `adduser <youruser> vboxusers`
 - `vagrant up`
 - Run `virtualbox` and in preferences attach the desired USB device
 - `vagrant up`
 - Configure calibre however you like
 - Optional: change the `vm.gui` option in the `Vagrantfile` to `false` if you want it to run headless
