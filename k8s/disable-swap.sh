sudo swapon --show
sudo swapoff -a #temporary disabled

#permanently disabled the swap
: <<'END'
sudo nano /etc/fstab

#looks like
/dev/zram0 none swap 0 0

comment that line 
save and sudo reboot

check using
sudo swapon --show

or disabled using systemctl

sudo systemctl stop zram-swap
sudo systemctl disable zram-swap
END
