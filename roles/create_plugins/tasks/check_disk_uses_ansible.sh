#!/usr/bin/env bash

### ======================================================================= ###
###     A Nagios plugin to check disk uses for a given disk or mount point  ###
###     Uses: ./check_disk_uses.sh /                                        ###
###           ./check_disk_uses.sh /mnt                                     ###
###           ./check_disk_uses.sh /dev/sda1                                ###
### ======================================================================= ###

### ======================================================================= ###
###                         FUNCTIONS                                       ###
### ======================================================================= ###

calculate_disk_uses(){
    # Calculate disk uses
    USED_DISK_SPACE=`df -h ${MOUNT_POINT} | grep -v Filesystem | awk '{print $5}' | sed 's/%//g'`
    if (($USED_DISK_SPACE>=0 && $USED_DISK_SPACE<=80)); then
    #if (($USED_DISK_SPACE>=0 && $USED_DISK_SPACE<=80)); then
        echo "Ok - ${USED_DISK_SPACE}% of disk space used."
        exit 0
    elif (($USED_DISK_SPACE>=81 && $USED_DISK_SPACE<=90)); then
        echo "WARNING - ${USED_DISK_SPACE}% of disk space used."
        exit 1
    elif (($USED_DISK_SPACE>=91 && $USED_DISK_SPACE <=100)); then
        echo "CRITICAL - ${USED_DISK_SPACE}% of disk space used."
        exit 2
    else
        echo "UNKNOWN - ${USED_DISK_SPACE}% of disk space used."
        exit 3
    fi
}

### ======================================================================= ###
###                         SCRIPT EXECUTION STARTS HERE                    ###
### ======================================================================= ###

if [[ -z "$1" ]] 
then
        echo "Missing parameters! Syntax: ./`basename $0` mount_point/disk"
        exit 3
else
        MOUNT_POINT=$1
fi

calculate_disk_uses

### ======================================================================= ###
###                         END OF SCRIPT                                   ###
### ======================================================================= ###
