#!/bin/sh
apt-get update -y
apt-get upgrade -y

cd "$(dirname "$0")"
DIR="$(pwd)"
apt-get install git build-essential cmake automake libtool autoconf -y
cd /opt/
git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build && cd xmrig/scripts
./build_deps.sh && cd ../build
cmake .. -DXMRIG_DEPS=scripts/deps
make -j$(nproc)

#bash -c "echo vm.nr_hugepages=1280 >> /etc/sysctl.conf"
cp $DIR/xmrig.service /etc/systemd/system/
cp $DIR/start.sh /opt/xmrig/build/
touch /opt/xmrig/build/config.json
systemctl daemon-reload
