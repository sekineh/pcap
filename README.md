[![Build status](https://api.travis-ci.org/sekineh/pcap-alt.svg)](https://travis-ci.org/sekineh/pcap-alt) 
[![Build status](https://ci.appveyor.com/api/projects/status/a9c075pkdbg8u3q7?svg=true)](https://ci.appveyor.com/project/sekineh/pcap-alt)

# pcap-alt

A folk of `pcap` crate, a idiomatic wrapper to the libpcap/WinPcap library.

Tested on:
- Rust Windows 64-bit/32-bit MSVC `stable` toolchain + WinPcap 4.1.3
  - x86_64-pc-windows-msvc (64-bit MSVC)
  - i686-pc-windows-msvc (32-bit MSVC)

### [Documentation](https://docs.rs/pcap)

This is a **Rust language** crate for accessing the packet sniffing capabilities of pcap (or wpcap on Windows).
If you need anything feel free to post an issue or submit a pull request!

## Features:

* List devices
* Open capture handle on a device or savefiles
* Get packets from the capture handle
* Filter packets using BPF programs
* List/set/get datalink link types
* Configure some parameters like promiscuity and buffer length
* Write packets to savefiles
* Inject packets into an interface

See examples for usage.

# Building

## Windows

Install [WinPcap](http://www.winpcap.org/install/default.htm).

For MSVC toolchain, unpack [WpdPack_4_1_2.zip](http://www.winpcap.org/install/bin/WpdPack_4_1_2.zip)
and set up the `LIB` environment varible to point the location of `wpcap.lib`
```
# for 64 bit
cmd> set LIB=c:\path\to\WpdPack\Lib\x64
# for 32 bit
cmd> set LIB=c:\path\to\WpdPack\Lib
```

Place wpcap.dll in your `C:\Rust\bin\rustlib\x86_64-pc-windows-gnu\lib\` directory on 64 bit
or `C:\Rust\bin\rustlib\i686-pc-windows-gnu\lib\` on 32 bit.

## Linux

On Debian based Linux, install `libpcap-dev`. If not running as root, you need to set capabilities like so: ```sudo setcap cap_net_raw,cap_net_admin=eip path/to/bin```

## Mac OS X

libpcap should be installed on Mac OS X by default.

**Note:** A timeout of zero may cause ```pcap::Capture::next``` to hang and never return (because it waits for the timeout to expire before returning). This can be fixed by using a non-zero timeout (as the libpcap manual recommends) and calling ```pcap::Capture::next``` in a loop.

## Library Location

If `PCAP_LIBDIR` environment variable is set when building the crate, it will be added to the linker search path - this allows linking against a specific `libpcap`.

## Optional Features

#### `tokio`

Use the `tokio` feature to enable support for streamed packet captures.

```toml
[dependencies]
pcap = { version = "0.7", features = ["tokio"] }
```

#### `pcap-savefile-append`

To get access to the `Capture::savefile_append` function (which allows appending
to an existing pcap file) you have to depend on the `pcap-savefile-append`
feature flag. It requires at least libpcap version 1.7.2.

```toml
[dependencies]
pcap = { version = "0.7", features = ["pcap-savefile-append"] }
```

#### `pcap-fopen-offline-precision`

To enable `Capture::from_raw_fd_with_precision` constructor (which allows opening
an offline capture from a raw file descriptor with a predefined timestamp precision)
you have to add `pcap-fopen-offline-precision` feature flag. This requires libpcap
version 1.5.0 or later.

```toml
[dependencies]
pcap = { version = "0.7", features = ["pcap-fopen-offline-precision"] }
```

## License

Licensed under either of

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally
submitted for inclusion in the work by you, as defined in the Apache-2.0
license, shall be dual licensed as above, without any additional terms or
conditions.
