sudo chown root:root /usr/local/bin/appnya
sudo chmod +x /usr/local/bin/appnya

sudo systemctl daemon-reload
sudo systemctl enable appnya
sudo systemctl start appnya
sudo systemctl status appnya
sudo systemctl restart appnya

#check is everything is runnine fine
journalctl -u appnya -f
