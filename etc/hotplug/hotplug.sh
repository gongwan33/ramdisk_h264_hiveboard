#!/bin/sh

case $MDEV in
udisk | sda1)
	DEVNAME=udisk
	MOUNTPOINT=/udisk
	;;
sdcard | mmcblk0p1)
	DEVNAME=sdcard
	MOUNTPOINT=/sdcard
	;;
*)
	exit 0
	;;
esac

test ! -c /dev/null && mknod -m 0666 /dev/null c 1 3

case $ACTION in
remove)
	/bin/umount $MOUNTPOINT || true
	rmdir $MOUNTPOINT >/dev/null 2>&1 || true
	;;
*)
	/bin/mkdir $MOUNTPOINT > /dev/null 2>&1 || true
	/bin/mount -o sync -o noatime -o nodiratime -o iocharset=utf8 -t vfat /dev/$DEVNAME $MOUNTPOINT > /dev/null 2>&1 || true
#	/bin/mount -t ext3 /dev/$DEVNAME $MOUNTPOINT > /dev/null 2>&1 || true
	;;
esac

exit 0
