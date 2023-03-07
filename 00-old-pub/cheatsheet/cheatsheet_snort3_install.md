# Cheatsheet Snort3 install

Enable PowerTools repo within the first steps:
```
$ dnf config-manager --add-repo /etc/yum.repos.d/CentOS-PowerTools.repo
$ dnf config-manager --set-enabled PowerToo
```

Setup lib and lib64 in the linker caching paths:
```
$ vi /etc/ld.so.conf.d/local.conf
/usr/local/lib
/usr/local/lib64
/opt/libdaq/lib
```

## Snort3 Dependencies

Install:
```
$ dnf install wget vim git flex bison gcc gcc-c++ make cmake automake autoconf libtool libpcap-devel pcre-devel libdnet-devel hwloc-devel openssl-devel zlib-devel luajit-devel pkgconfig libmnl-devel libunwind-devel libnfnetlink-devel libnetfilter_queue-devel
```

LibDAQ Install:
```
$ mkdir source
$ cd source
$ git clone https://github.com/snort3/libdaq.git
$ cd libdaq/
$ ./bootstrap
$ ./configure --help
$ ./configure --prefix=/opt/libdaq
$ make
$ make install
$ ldconfig
```

## Optional Dependencies

LZMA and UUID:
```
$ dnf install xz-devel libuuid-devel -y
```

## Hyperscan

Dependencies:
```
$ dnf install python3 sqlite-devel colm ragel -y
$ curl -LO https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.gz
$ tar xf boost_1_73_0.tar.gz
```

Download and install hyperscan(5.3.0):
```
$ curl -Lo hyperscan-5.3.0.tar.gz https://github.com/intel/hyperscan/archive/v5.3.0.tar.gz
$ tar xf hyperscan-5.3.0.tar.gz
$ mkdir hs-build && cd hs-build
```

BOOST_ROOT:
```
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBOOST_ROOT=../boost_1_73_0 ../hyperscan-5.3.0
```

Proceed with installing Hyperscan.
```
$ make -j$(nproc)
$ make -j$(nproc) install 
```

Flatbuffers:
```
$ curl -Lo flatbuffers-1.12.tar.gz https://github.com/google/flatbuffers/archive/v1.12.0.tar.gz
$ tar xf flatbuffers-1.1  2.tar.gz
$ mkdir fb-build && cd fb-build
$ cmake ../flatbuffers-1.12.0 
$ make -j$(nproc)
$ make -j$(nproc) install 
$ ldconfig
```

Safec
```
$ dnf install libsafec libsafec-devel
$ ln -s /usr/lib64/pkgconfig/safec-3.3.pc /usr/local/lib64/pkgconfig/libsafec.pc
```

Tcmalloc
```
$ dnf install gperftools-devel
```

## Installing Snort3

```
$ git clone https://github.com/snort3/snort3.git
$ cd snort3

$ export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
$ export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH
$ export PKG_CONFIG_PATH=/opt/libdaq/lib/pkgconfig:$PKG_CONFIG_PATH

$ ./configure_cmake.sh --prefix=/usr/local/snort --enable-tcmalloc

$ cd build/
$ make -j$(nproc)
$ make -j$(nproc) install

$ /usr/local/snort/bin/snort –V
```