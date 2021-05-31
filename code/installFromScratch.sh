sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
sudo apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
#BerkleyDB for wallet support
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
#upnp
sudo apt-get install -y libminiupnpc-dev
#ZMQ
sudo apt-get install -y libzmq3-dev

#remove this commet to build with qt-gui
# sudo apt-get -y install libqrencode-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler
# cp ./litecoin/src/qt/res/icons/litecoin_splash.png ./litecoin/src/qt/res/icons/athoscoin_splash.png
sudo apt autoremove -y
cd code
echo "******************************************************"
echo "******************************************************"
echo "******************************************************"
echo "Renaming files Litecoin/Athoscoin"
find ./ -type f -readable -writable -exec sed -i "s/Litecoin/Athoscoin/g" {} \;
echo "Renaming files LiteCoin/AthosCoin"
find ./ -type f -readable -writable -exec sed -i "s/LiteCoin/AthosCoin/g" {} \;
echo "Renaming files LTC/ATC"
find ./ -type f -readable -writable -exec sed -i "s/LTC/ATC/g" {} \;
echo "Renaming files litecoin/athoscoin"
find ./ -type f -readable -writable -exec sed -i "s/litecoin/athoscoin/g" {} \;
echo "Renaming files litecoind/athoscoind"
find ./ -type f -readable -writable -exec sed -i "s/litecoind/athoscoind/g" {} \;

echo "Renaming files lites/blessings"
find ./ -type f -readable -writable -exec sed -i "s/lites/blessings/g" {} \;
echo "Renaming files photons/graces"
find ./ -type f -readable -writable -exec sed -i "s/photons/graces/g" {} \;

echo "Changing magic number"

sed -i "s/pchMessageStart\[0\] = 0xfb/pchMessageStart\[0\] = 0x65/g" ./src/chainparams.cpp
sed -i "s/pchMessageStart\[1\] = 0xc0/pchMessageStart\[1\] = 0x66/g" ./src/chainparams.cpp
sed -i "s/pchMessageStart\[2\] = 0xb6/pchMessageStart\[2\] = 0x70/g" ./src/chainparams.cpp
sed -i "s/pchMessageStart\[3\] = 0xdb/pchMessageStart\[3\] = 0x80/g" ./src/chainparams.cpp

echo "Changing base58Prefixes"
sed -i "s/base58Prefixes\[PUBKEY_ADDRESS\] = std::vector<unsigned char>(1,48)/base58Prefixes\[PUBKEY_ADDRESS\] = std::vector<unsigned char>(1,65)/g" ./src/chainparams.cpp
sed -i "s/base58Prefixes\[SECRET_KEY\] =     std::vector<unsigned char>(1,176)/base58Prefixes\[SECRET_KEY\] =     std::vector<unsigned char>(1,65)/g" ./src/chainparams.cpp
sed -i "s/base58Prefixes\[EXT_PUBLIC_KEY\] = {0x04, 0x88, 0xB2, 0x1E}/base58Prefixes\[EXT_PUBLIC_KEY\] = {0xfa, 0x88, 0xB2, 0x1E}/g" ./src/chainparams.cpp
sed -i "s/base58Prefixes\[EXT_SECRET_KEY\] = {0x04, 0x88, 0xAD, 0xE4}/base58Prefixes\[EXT_SECRET_KEY\] = {0xfa, 0x88, 0xAD, 0xE4}/g" ./src/chainparams.cpp
        
echo "******************************************************"
echo "******************************************************"
echo "******************************************************"
echo "Building"
echo "******************************************************"
echo "******************************************************"
echo "******************************************************"
./autogen.sh
./configure --disable-man
make -j 8

./src/athoscoind -deprecatedrpc=generate --printtoconsole

