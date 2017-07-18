
FOLDER=/tmp/build_tmux
if [ ! -d $FOLDER ]; then
  mkdir -p $FOLDER
fi

rm -rf $FOLDER/*
cd $FOLDER
# Download libevent
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar xvf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./autogen.sh
./configure --prefix=/opt/local && make -j16 && sudo make install

# Download and install tmux
cd $FOLDER
if [ -d tmux ]; then
  rm -rf tmux
fi
git clone https://github.com/tmux/tmux.git
cd tmux
git checkout tags/2.5

export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig
sh autogen.sh
./configure --prefix=/opt/local/ && make -j16 && sudo make install
