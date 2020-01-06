# rtl8821cu

Wifi driver for rtl8811cu/rtl8821cu

### Install
```
sudo ./dkms-install.sh
```
### Remove
```
sudo ./dkms-remove.sh
```

## Build and install without DKMS

```
~$ sudo apt install bc linux-headers-$(uname -r)
```

Use following commands in source directory:

```
make
sudo make install
sudo modprobe 8821cu
```

## Raspberry Pi

To build this driver on Raspberry Pi you need to set correct platform in Makefile.
Change

```
CONFIG_PLATFORM_I386_PC = y
CONFIG_PLATFORM_ARM_RPI = n
CONFIG_PLATFORM_ARM_RPI3 = n
```
to
```
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_RPI = y
CONFIG_PLATFORM_ARM_RPI3 = n
```
For the Raspberry Pi 3 you need to change it to
```
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_RPI = n
CONFIG_PLATFORM_ARM_RPI3 = y
```

### Plug your USB-wifi-adapter into your PC
If wifi can be detected, congratulations.
If not, maybe you need to switch your device usb mode by the following steps in terminal:
1. find your usb-wifi-adapter device ID, like "0bda:1a2b", by type:
```
lsusb
```
2. switch the mode by type: (the device ID must be yours.)

Need install `usb_modeswitch` (debian: `sudo apt install usb_modeswitch`)
```
sudo usb_modeswitch -KW -v 0bda -p 1a2b
```

It should work.

### Modeswitch

Just modify the file */lib/udev/rules.d/40-usb_modeswitch.rules* appending before the line *LABEL="modeswitch_rules_end"* with:
```
# Realtek 8811CU/8821CU Wifi AC USB
ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="usb_modeswitch -K -v 0bda -p 1a2b"
```