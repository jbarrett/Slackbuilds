#!/bin/sh

# Based on source/n/network-scripts/doinst.sh - fuzzix

# Handle the incoming configuration files:
config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}
config etc/rc.d/rc.firewall.new
config etc/iptables/iptables.rules.new
config etc/iptables/ip6tables.rules.new

# OK, some of these aren't useful as examples, and have to be
# considered clutter if you've already got the file.
# So out they go.
rm -f etc/iptables/iptables.rules.new
rm -f etc/iptables/ip6tables.rules.new

