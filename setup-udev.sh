#!/usr/bin/env bash

cat > /lib/udev/rules.d/75-persistent-net-generator.rules <<EOF
# rename to wlan0
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="08:1f:71:2c:26:8b", NAME="wlan0"
EOF

# usb modeswitch, eject usb disk cdrom when wifi-adapter plug-in
f_usb_modeswitch_rules=/lib/udev/rules.d/40-usb_modeswitch.rules
if grep -E '0bda(.*)1a2b' $f_usb_modeswitch_rules > /dev/null; then
 exit
fi

sed '/modeswitch_rules_end/d' -i $f_usb_modeswitch_rules
cat >> $f_usb_modeswitch_rules <<EOF
# Realtek 8811CU/8821CU Wifi AC USB
ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="/usr/sbin/usb_modeswitch -K -v 0bda -p 1a2b"

LABEL="modeswitch_rules_end"
EOF

