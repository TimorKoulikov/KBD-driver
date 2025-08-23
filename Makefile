
all: run
run:
	qemu-system-x86_64 -m 512M -kernel linux-6.12.43/arch/x86_64/boot/bzImage -initrd rootfs.cpio.gz  -append "root=/dev/mem"

