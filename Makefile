
all: run

#must build busyBox in ./busybox
build:
	mkdir rootfs
	mdkir rootfs -p rootfs/{bin,sbin,etc,proc,usr/{bin,sbin}}
	cp -av busybox/_install/* rootfs/
	ln -sf  ./rootfs/bin/busybox ./rootfs/init
	mkdir rootfs/dev
	mknod -m 660 rootfs/dev/mem c 1 1
	mknod -m 660 rootfs/dev/tty2 c 4 2
	mknod -m 660 rootfs/dev/tty3 c 4 3
	mknod -m 660 rootfs/dev/tty4 c 4 4
	find ./rootfs -print0 | cpio --null -ov --format=newc | gzip -9 > ../rootfs.cpio.gz

run:
	qemu-system-x86_64 -m 512M -kernel linux-6.12.43/arch/x86_64/boot/bzImage -initrd rootfs.cpio.gz  -append "root=/dev/mem"

