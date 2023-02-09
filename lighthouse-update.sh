echo 'Stop beacon-chain and validator'
sudo systemctl stop beacon-chain validator
echo 'Wait for validator to stop...'
while [ $(sudo systemctl is-active validator) = 'active' ]; do
    echo '...'
    sleep 5
done
echo 'Stopped'
echo 'Wait for beacon-chain to stop...'
while [ $(sudo systemctl is-active beacon-chain) = 'active' ]; do
    echo '...'
    sleep 5
done
echo 'Stopped'
echo 'Download latest lighthouse release'
curl -Ls https://api.github.com/repos/sigp/lighthouse/releases/latest | grep -wo "https.*x86_64-unknown-linux-gnu.tar.gz" | wget -qi -
echo 'Unzip package and install'
tar -xvf lighthouse-*-x86_64-unknown-linux-gnu.tar.gz
rm lighthouse-*-x86_64-unknown-linux-gnu.tar.gz*
sudo mv -f lighthouse /usr/bin
echo 'Restart beacon-chain and validator'
sudo systemctl daemon-reload
sudo systemctl start beacon-chain validator
lighthouse --version
journalctl -fu beacon-chain
