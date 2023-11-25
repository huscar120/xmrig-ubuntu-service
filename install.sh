#!/bin/sh
apt-get update -y
apt-get upgrade -y

apt-get install git build-essential cmake automake libtool autoconf
git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build && cd xmrig/scripts
./build_deps.sh && cd ../build
cmake .. -DXMRIG_DEPS=scripts/deps
make -j$(nproc)


bash -c "echo vm.nr_hugepages=1280 >> /etc/sysctl.conf"
mv xmrig.service /etc/systemd/system/
mv start.sh xmrig/build/
systemctl daemon-reload
