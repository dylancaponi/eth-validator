echo "Stop Erigon"
sudo systemctl stop eth1

echo 'Wait for Erigon to stop...'
while [ $(sudo systemctl is-active eth1) = 'active' ]; do
    echo '...'
    sleep 5
done

echo "Pull Erigon"
cd erigon
git pull
echo "Make Erigon"
make erigon

echo "Start Erigon"
sudo systemctl start eth1
build/bin/erigon --version
journalctl -fu eth1
