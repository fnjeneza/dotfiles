#!/bin/sh
# Retrieve the IPv4 address of the station

# get default interface
DEFAULT_INTERFACE=`ip route | grep default | awk '{print $5}'`

if [ $DEFAULT_INTERFACE ]; then
    IP_ADDRESS=`ip -o -4 addr | grep $DEFAULT_INTERFACE | awk '{print $4}'`
    echo $IP_ADDRESS
else
    echo "no IP"
fi
